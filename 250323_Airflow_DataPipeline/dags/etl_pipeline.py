from datetime import datetime, timedelta, timezone
from airflow import DAG
from airflow.models import Variable
from airflow.providers.google.cloud.operators.bigquery import (
    BigQueryExecuteQueryOperator,
    BigQueryCreateEmptyDatasetOperator,
    BigQueryCreateEmptyTableOperator
)
from airflow.providers.google.cloud.operators.bigtable import (
    BigtableCreateInstanceOperator
)
from airflow.operators.python import PythonOperator
from airflow.providers.google.cloud.sensors.pubsub import PubSubPullSensor
from google.cloud import bigtable
from google.cloud import bigquery
from airflow.exceptions import AirflowException

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
}

def load_bigquery_to_bigtable(**kwargs):
    """Custom function to transfer data from BigQuery to Bigtable"""
    try:
        # Initialize clients
        bq_client = bigquery.Client(project=kwargs['project_id'])
        bt_client = bigtable.Client(project=kwargs['project_id'])
        instance = bt_client.instance(kwargs['instance_id'])
        table = instance.table(kwargs['table_id'])
        
        # Query BigQuery
        query = f"SELECT * FROM `{kwargs['project_id']}.{kwargs['dataset_id']}.{kwargs['source_table']}`"
        rows = bq_client.query(query).result()
        
        # Insert into Bigtable with current UTC time
        current_time = datetime.now(timezone.utc)
        for row in rows:
            row_key = str(row[kwargs['row_key_column']])
            row_data = table.direct_row(row_key)
            for column, value in row.items():
                row_data.set_cell(
                    kwargs['column_family'],
                    column.encode('utf-8'),
                    str(value).encode('utf-8'),
                    current_time
                )
            row_data.commit()
        return True
    except Exception as e:
        raise AirflowException(f"BigQuery to Bigtable transfer failed: {str(e)}")

with DAG(
    'etl_pipeline',
    default_args=default_args,
    description='ETL pipeline from GCS to BigQuery/Bigtable',
    schedule_interval=None,
    start_date=datetime(2023, 1, 1, tzinfo=timezone.utc),
    catchup=False,
    tags=['gcp', 'etl'],
) as dag:

    PROJECT_ID = Variable.get("gcp_project_id", default_var="airflowpub")
    GCP_CONN_ID = Variable.get("gcp_conn_id", default_var="google_cloud_default")
    DATASET_ID = "etl_dataset"
    SOURCE_TABLE = "gcs_file_logs"
    PROCESSED_TABLE = "processed_files"
    
    # Create dataset if not exists
    create_bq_dataset = BigQueryCreateEmptyDatasetOperator(
        task_id='create_bq_dataset',
        dataset_id=DATASET_ID,
        location='US',
        exists_ok=True,
        project_id=PROJECT_ID,
        gcp_conn_id=GCP_CONN_ID
    )

    # Create source table if not exists
    create_source_table = BigQueryCreateEmptyTableOperator(
        task_id='create_source_table',
        dataset_id=DATASET_ID,
        table_id=SOURCE_TABLE,
        project_id=PROJECT_ID,
        gcp_conn_id=GCP_CONN_ID,
        exists_ok=True,
        schema_fields=[
            {"name": "bucket", "type": "STRING", "mode": "REQUIRED"},
            {"name": "name", "type": "STRING", "mode": "REQUIRED"},
            {"name": "timeCreated", "type": "TIMESTAMP", "mode": "REQUIRED"},
            {"name": "processed", "type": "BOOLEAN", "mode": "REQUIRED"}
        ]
    )

    listen_for_files = PubSubPullSensor(
        task_id='listen_for_files',
        project_id=PROJECT_ID,
        subscription='etl-subscription',
        gcp_conn_id=GCP_CONN_ID,
        max_messages=10,
        ack_messages=True,
        poke_interval=30
    )

    create_bigtable_instance = BigtableCreateInstanceOperator(
        task_id='create_bigtable_instance',
        instance_id='etl-instance',
        instance_display_name='ETL Pipeline Instance',
        instance_type='PRODUCTION',
        main_cluster_id='etl-cluster',
        main_cluster_zone='us-central1-a',
        cluster_nodes=3,
        cluster_storage_type='SSD',
        project_id=PROJECT_ID,
        gcp_conn_id=GCP_CONN_ID,
        retries=5,
        retry_delay=timedelta(minutes=2),
        trigger_rule='all_failed'
    )
    
    bq_transform = BigQueryExecuteQueryOperator(
        task_id='bq_transform',
        sql=f'''
        SELECT 
            bucket as source_bucket,
            name as file_name,
            timeCreated as upload_time
        FROM `{PROJECT_ID}.{DATASET_ID}.{SOURCE_TABLE}`
        WHERE processed = false
        ''',
        gcp_conn_id=GCP_CONN_ID,
        destination_dataset_table=f'{PROJECT_ID}.{DATASET_ID}.{PROCESSED_TABLE}',
        write_disposition='WRITE_APPEND',
        use_legacy_sql=False,
        location='US'
    )

    load_to_bigtable = PythonOperator(
        task_id='load_to_bigtable',
        python_callable=load_bigquery_to_bigtable,
        op_kwargs={
            'project_id': PROJECT_ID,
            'instance_id': 'etl-instance',
            'table_id': 'processed_files',
            'dataset_id': DATASET_ID,
            'source_table': PROCESSED_TABLE,
            'column_family': 'cf1',
            'row_key_column': 'file_name'
        }
    )

    # Set up dependencies
    create_bq_dataset >> create_source_table
    [create_source_table, create_bigtable_instance] >> listen_for_files
    listen_for_files >> bq_transform >> load_to_bigtable
