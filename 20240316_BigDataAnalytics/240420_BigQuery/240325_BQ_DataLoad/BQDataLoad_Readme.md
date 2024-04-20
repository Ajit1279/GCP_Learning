- Reference: https://cloud.google.com/bigquery/docs/loading-data

- There are several ways to ingest data into BigQuery:
  - **Batch load** a set of data records. **Can be one time or recurring**
    - **Load Jobs**:
      - Load data **from Cloud Storage** or **from a local file (in Avro, [CSV](https://github.com/Ajit1279/GCP_Learning/tree/main/20240316_BigDataAnalytics/20240325_BQ_DataLoad/20240406_CSVLoad_Python), JSON, ORC, or Parquet format)** by creating a load job
      - Require **staging the data to intermediate storage** (e.g. Cloud Storage).
      - **Most suitable for file-based patterns** 

    - **SQL** : **LOAD DATA SQL statement** to load Avro, CSV, JSON, ORC, or Parquet files.

    - **BigQuery Data Transfer Service** : Automate loading data **from Google Software as a Service (SaaS) apps or from third-party applications** and services.

    - **BigQuery Storage Write API**: **batch-process an arbitrarily large number of records** and **retry if single atomic operation fails**.

    - **Other managed services**: Import the **data extracted from external data store** into BigQuery (e.g. load data from Firestore exports).

  - **[Stream](https://cloud.google.com/bigquery/docs/loading-data#streaming) individual records** or smaller batches of records.
    - **Storage Write API**: The Storage Write API supports **high-throughput streaming ingestion** with exactly-once delivery semantics.

    - **DataFlow:**  Set up a **streaming pipeline** using **Dataflow with the Apache Beam SDK**

    - **[DataStream](https://cloud.google.com/datastream-for-bigquery?hl=en)** to **replicate data and schema updates from operational databases** directly into BigQuery.

    - **BigQuery Connector for SAP**: Near real time replication of SAP data

    - **Pub/sub:**: **To coordinate streaming analytics and data integration pipelines**  

  - Use **queries to generate new data** and append or **overwrite the results to a table**.

  - Use a **third-party application** or service. e.g. Informatica Data Loader, Fivetran Data Pipelines

-  **[Choosing Data Ingestion Methods](https://cloud.google.com/bigquery/docs/loading-data#choosing_a_data_ingestion_method)**: Factors which determine it are:
  - **Data Source** e.g.
    - For **Spark or Hadoop**, consider using [BigQuery connectors](https://cloud.google.com/dataproc/docs/concepts/connectors/bigquery)
    - For **third party sources**, transform the data into a format supported by batch loading
    - Transfer the data **directly into BigQuery** if **BigQuery Data Transfer Service supports the data source**
    - For **application data**, **stream the data** in real time
  
  - **Slow changing vs Fast changing data**
    - **Consider streaming for analyze data in near real-time**
    - **For frequently updated data, stream a change log and use a view**
    - Use **Cloud SQL as** your online transaction processing **(OLTP) database** and use **federated queries to join the data** in BigQuery.
    - For a **daily or hourly report, use load jobs**
    - If **data arrives infrequently or in response to an event**, use **Dataflow** or use **Cloud Functions to call the streaming API** in response to a trigger.
  
  - **Reliability of the solution**
    - With **loosely typed formats (e.g. JSON or CSV)**, bad data can make an entire load job fail. Consider **data cleansing step** before loading
    - The **scheduling component (e.g. Cloud Composer, Cron)** could be a **failure point** in the solution.
    - With **streaming**, you can **check the success of each record** and quickly report an error.
    - **Streaming and load jobs** are subject **to quotas**. **Handle quota errors**
    - **Third-party solutions might differ in configurability, reliability**
  
  - **Latency**: How much data you load and how soon you need the data to be available
    - **Streaming offers the lowest latency**
    - Periodic **load jobs have a higher latency**
    - For **minimizing query latency load the data into BigQuery.**
  
  - **Data Ingesion Format**
    - BigQuery creates the table **schema automatically** based on the source data for **Avro, ORC, Parquet, and Firestore exports**
    - For **JSON and CSV data**, you can **provide an explicit schema, or you can use schema auto-detection**.
    - **Nested and repeated fields** also reduce data duplication when loading the data.
    - **BigQuery expects newline-delimited JSON files** to contain a single record per line.
    - BigQuery supports **UTF-8 encoding for both nested / repeated and flat data**. BigQuery supports **ISO-8859-1 encoding for flat data only** for CSV files.
    - 
  
