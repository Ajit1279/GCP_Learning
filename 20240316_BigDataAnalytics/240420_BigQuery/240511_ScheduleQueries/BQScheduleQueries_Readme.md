- Reference: https://cloud.google.com/bigquery/docs/scheduling-queries
- Basics:
  - To run queries on recurring basis
  - Queries must be written in [GoogleSQL](https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax) and can include [DDL](https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language) and [DML](https://cloud.google.com/bigquery/docs/data-manipulation-language) statements.
  - Queries **can reference tables from different projects and different datasets**.
  - The **destination dataset can be specified separately**, but it must be in the **same project as the scheduled query**.
  - The scheduled time for the query is **converted** from your **local time to UTC** (Not affected by daylight saving time).
  - The **scheduled query fails if the table schema changes** between runs.
  - The destination tables can be partitioned, non-partitioned, [clustered](https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#creating_a_clustered_table_from_the_result_of_a_query) (new tables only).
  - You can set-up [queries with service account](https://cloud.google.com/bigquery/docs/scheduling-queries#set_up_scheduled_queries_with_a_service_account). 
  
- [Set-up scheduled queries using Python](https://cloud.google.com/bigquery/docs/scheduling-queries#python)
  - Please ensure to enable "Identity and Access Management (IAM) API" before proceeding
  
  - Create a Service Account
    gcloud iam service-accounts create bqsa-123@mybqproj0427.iam.gserviceaccount.com \
    --description="Service Account to schedule Queries in BigQuery" \
    --display-name="bqsa-123"

  - It gave an error message:
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/bade2127-8a0f-4e6e-852b-be2566145f87)

  - To resolve, ran the [following command](https://cloud.google.com/sdk/gcloud/reference/iam/service-accounts/create) instead: gcloud iam service-accounts create bqsa-123 --display-name="My BigQuery Scheduler Service Account"
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b55f72bf-fa8d-48af-a997-41b23a58b295)

  - Create a [Python program](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240511_ScheduleQueries/Python_ScheduleQuery.py) 

- Run it using command python3 bqschedule.py. It gave an error:
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0995e856-8a76-41f9-b808-53a8d1ddef84)

- So ran the command: python -m pip install --upgrade pip but the error still persists
- 
- sd
- sd
- sd
- sd
