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

  - Please ensure to [set-up Python Virtual Environment](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240413_Dataflow/Dataflow_Readme.md) if you haven't already in the project
  
  - Run it using command python3 bqschedule.py. It gave an error:
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0995e856-8a76-41f9-b808-53a8d1ddef84)

  - So ran the command: python -m pip install --upgrade pip but the error still persists

  - Run the command: **pip install google-cloud-bigquery-datatransfer**

  - Also enable the BigQuery Data Transfer API, otherwise there's an error message
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/26ac87d2-a21f-4357-9ac4-5787ce85b03b)

  - Referring to the API page run the command: gcloud services enable bigquerydatatransfer.googleapis.com 

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/28e036dc-0c45-468d-9f95-a68469dad795)
   
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c91f3ea5-d687-4926-9e66-39eb40f2b1c4)
  
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e6777e49-4da7-4712-bea6-17fc61dd296b)

  - Now execute the Python program again. It gave an error, so created the dataset
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fba13245-a547-43bc-9441-2ff088da28c5)

  - Refer this program to [create dataset programmatically](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240427_CreateBQResources/main.py). For this example let's create it manually and rerun the program.

  - It displays the message:
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/dad5452d-86b5-4863-b414-3928d32da7fe)
  
  - Go to Console >> BigQuery >> BigQuery Studio >> Scheduled Queries. It displays screen as shown below:
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/955a4ca1-7931-41e4-865e-2335d79c0cb2)

  - If you click on the link, it displays that access was denied on the table / table does not exist
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2b3caca1-1cfa-4c77-a68e-dc06f648630b)

  - To resolve the issue copy the service account name: bqsa-123@mybqproj0427.iam.gserviceaccount.com

  - Referring to [documentation](https://cloud.google.com/bigquery/docs/control-access-to-resources-iam), go to BigQuery Pane >> Project Name >> Right Click on Dataset Name >> Share >> Manage Permissions >> Add permissions
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7ce32b49-de2a-4a20-a2cf-ad0c470145fe)

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b786019e-b263-4985-99c1-6a6005b739aa)

  - Add the service account name in the "Add prinicipals" field and then assign the role: BigQuery User
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/3b2e7621-d927-4f04-b262-7238a9663745)

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a7e939d2-b560-43f1-9c70-b97da603cf32)

  - Now let's run the python program again to check if it works!
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1fab60a6-b4ac-4841-a01b-e0e97bc2a331)

  - This time it failed with error: User does not have bigquery.jobs.create permission
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/36e12210-d3bd-42af-aeb0-54d7f504b80b)

  - bigquery.jobs.create is not available and referring to the [Bigquery documentation](https://cloud.google.com/bigquery/docs/access-control#bigquery.user), the bigquery.user role should have the required permission, but not working still.

  - So applied BigQuery Admin Role (which is too broad permission and not correct), but it didn't work still. So this will need further investigation. 

  - 
    
- sd
- sd
- sd
