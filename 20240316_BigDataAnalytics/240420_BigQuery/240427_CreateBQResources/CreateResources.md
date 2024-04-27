- [Create and organize BigQuery Resources](https://cloud.google.com/bigquery/docs/resource-hierarchy)
  - BigQuery inherits the Google Cloud resource hierarchy and adds an additional grouping mechanism called datasets, which are specific to BigQuery.

  - There are two [patterns](https://cloud.google.com/bigquery/docs/resource-hierarchy#patterns) for organizing BigQuery resources.
    - **Central data lake, department data marts:**
      - The **organization creates** a unified storage project to hold its **raw data**.
      - **Departments** within the organization create their own **data mart projects for analysis**.
    - **Department data lakes, central data warehouse**
      - Each **department** creates and manages its **own storage project to hold that department's raw data**.
      - The **organization** then creates a **central data warehouse** project **for analysis**.  

  - **[Datasets](https://cloud.google.com/bigquery/docs/datasets-intro)**
    - Datasets are **logical containers** used to organize and control access to your BigQuery resources.
    - Dataset has **locations**. It **cannot be changed** after it is created.
    - You can **include other resources** (tables, views, functions, procedures etc.) **in datasets**.
    - One need to **consider various parameters like location / location limitations, Quotas, Data Retention, Storage Billing Models, Pricing, Security** while creating.
    - [Create Datasets](https://cloud.google.com/bigquery/docs/datasets)
      - [Using the Google Cloud console](https://cloud.google.com/bigquery/docs/datasets#console)
      - [Using a SQL query.](https://cloud.google.com/bigquery/docs/datasets#sql)
      - [Using the bq mk command in the bq command-line tool.](https://cloud.google.com/bigquery/docs/datasets#bq)
      - [Terraform](https://cloud.google.com/bigquery/docs/datasets#terraform)
      - [Calling the datasets.insert API method.](https://cloud.google.com/bigquery/docs/datasets#api)
      - Using the client libraries e.g. [Python](https://cloud.google.com/bigquery/docs/datasets#python).
      - [Copying an existing dataset.](https://cloud.google.com/bigquery/docs/managing-datasets#copy-datasets)
    

    - In this hands-on lab we will be creating resources using Python

      - Select your project: **gcloud config set project mybqproj0427**
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2036fac7-a9f0-48b6-b954-dfb3bc5cb1c0)
     
      - Run main.py using command: python3 [main.py](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240427_CreateBQResources/main.py)

      - It displays:
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5563d00f-f79f-429e-91b0-7af2ddee8aec)
     
      - You can also list the datasets using the command: bq ls
     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9bc6104a-162f-439b-968e-f579392f87ea)
   
     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e3755acd-00e4-442c-98f3-130d96d75757)

      - Go to Console >> Explorer. It displays the empty dataset
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/bbd6daab-0604-45e3-a85c-3787078abe67)

      - Update dataset properties: One can also update dataset properties like access controls, billing model, expiration time, description, labels etc.
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9da57998-ec1b-44fc-836a-539415a50a1d)

    - Now let's [create tables](https://cloud.google.com/bigquery/docs/tables)
      - One can create Partitioned Tables or the [Clustered Tables](https://cloud.google.com/bigquery/docs/clustered-tables)

      - For this hands-on, let's create [Partitioned table](https://cloud.google.com/bigquery/docs/partitioned-tables)

      - It displays the message:
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/81f359af-4595-49c7-b46d-c1cb59dd1f37)

      - Verify in Console
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/aaaf5254-80f8-46a8-ab08-81399f5f73a9)

    - One can [load data in table using various methods](https://github.com/Ajit1279/GCP_Learning/tree/main/20240316_BigDataAnalytics/240420_BigQuery/240325_BQ_DataLoad)

    - You can also create views
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fe38d838-aefe-40b6-a8ea-cf5f54caf0e3)

      - In Console
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4ac2fb09-f1ee-4f9b-9311-d1fbae326dbd)
     
    - [Authorised and Materialised Views](https://cloud.google.com/bigquery/docs/authorized-views) 
      - **Share query results with particular users and groups without giving them access to the underlying source data**.

    - [Create Routines](https://github.com/Ajit1279/GCP_Learning/tree/main/20240316_BigDataAnalytics/240420_BigQuery/240427_CreateRoutines)

    - [Create Connections](https://github.com/Ajit1279/GCP_Learning/tree/main/20240316_BigDataAnalytics/240420_BigQuery/240427_Connections)  
