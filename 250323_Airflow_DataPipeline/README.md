# ETL Pipeline Using Apache Airflow (Cloud Composer)

---------------------------------------------
- **Project Overview**
  - Extract data from Cloud Storage (CSV files)
  - Transform data using Apache Airflow DAGs
  - Load data into BigQuery for analytics
  - Automate the workflow with Cloud Composer (Managed Airflow)

 ---------------------------------------------
- **Tech Stack**
  - **Apache Airflow (Cloud Composer)** - For Workflow Orchestration
  - **Google Cloud Storage (GCS)** - Data source (csv files)
  - **BigQuery** - Data Warehouse for Analytics
  - **Python** (Pandas) - For transformation)
  - **Google Cloud Functions** (Optional for automation) - Serverless Pub/Sub trigger
  - **Google Cloud Pub/Sub** - Event Driven Messages 

-------------------------------------- 
- **Project Directory Structure**

|etl-airflow-pipeline/
\
│──  README.md
\
│──  dags/                        # Airflow DAG scripts
\
│    ├── etl_pipeline.py           # Main DAG script
\
│    ├── extract.py                 # Extract data from GCS
\
│    ├── transform.py               # Clean and process data
\
│    ├── load.py                    # Load data into BigQuery
\
│── pubsub/
\
|    ├── pubsub_function.py        # Cloud Function for pubsub trigger
\
│──  data/                         # Sample CSV files
\
│──  config/                       # GCP connection configs
\
│──  logs/                         # Airflow logs
\
│──  requirements.txt              # Python dependencies
\
│──  deployment-guide.md           # step-by-step deployment guide

------------------------------------ 
- **High level process:**
  - CSV file is uploaded to **Google Cloud Storage**
  - **Cloud Function** triggers an event and publishes message to **Pub/Sub**
  - **Apache Airflow** detects the message and activates **Airflow DAG** and runs ETL process dynamically 
  - The transformed data is stored in **BigQuery**
-------------------------------------

- **Step by step instructions to set-up the infra and services:**
  - Grant your account the **"Service Usage Admin" role (roles/serviceusage.serviceUsageAdmin)** or the "Owner" role on the Google Cloud project

              gcloud projects add-iam-policy-binding airflowpub \
              --member="user:gcpajitk@gmail.com" \
              --role="roles/serviceusage.serviceUsageAdmin"
    
  - **Enable APIs:** Cloud Composer, BigQuery, Cloud Storage, Cloud Functions, Pub/Sub 
          
          gcloud services enable composer.googleapis.com \
              cloudfunctions.googleapis.com \
              run.googleapis.com \
              eventarc.googleapis.com \
              pubsub.googleapis.com \
              storage.googleapis.com \
              bigquery.googleapis.com \
              bigtableadmin.googleapis.com \
              bigtable.googleapis.com \
              dataflow.googleapis.com

  - **Please note:** if you receive an error: **PERMISSION_DENIED: Permission denied to enable service [serviceusage.googleapis.com]** try enabling it manually in Console or troubleshoot if required permission is missing or check if billing is enabled or not.

  - Check if the APIs are enabled or not using the command

             gcloud services list

      OR a particular API using

            gcloud services list | grep storage


      ![image](https://github.com/user-attachments/assets/d8799e36-ce3b-4dc9-b051-65dacb57c364)


  - **Create pub/sub topic and subscription**

            gcloud pubsub topics create etl-topic
            gcloud pubsub subscriptions create etl-subscription --topic=etl-topic

  - **Create a GCS Bucket**

            gcloud storage buckets create gs://airflow-pubsub-bucket --location=us-central1

  - We have already enabled Eventarc api, but Eventarc triggers rely on the Cloud Storage service agent to update metadata and set up Pub/Sub notifications. If it doesn’t have the right permissions, the trigger creation will fail. Please run the command below (or the values can be hard coded as well)
 
  - Check if the Cloud Srorage Service Account exists by running command (Please note this service account does not appear in the iAM. You wil need to go to buckets >> permission within the console 

            PROJECT_NUMBER=$(gcloud projects list --filter="$(gcloud config get-value project)" --format="value(PROJECT_NUMBER)")
            echo "Your Cloud Storage service account is:"
            echo "service-$PROJECT_NUMBER@gs-project-accounts.iam.gserviceaccount.com"

  - If it exists, run the below command to grant pub sub publisher access 

            PROJECT_ID=$(gcloud config get-value project)
            PROJECT_NUMBER=$(gcloud projects list --filter="$(gcloud config get-value project)" --format="value(PROJECT_NUMBER)")

            gcloud projects add-iam-policy-binding $PROJECT_ID \
              --member="serviceAccount:service-$PROJECT_NUMBER@gs-project-accounts.iam.gserviceaccount.com" \
              --role="roles/pubsub.publisher"
  -  
    

  - **Deploy Cloud Function for pub/sub trigger**
    - Create [main.py](https://github.com/Ajit1279/GCPStaging/blob/main/pubsub/main.py) in pubsub  directory

    - Create [requirements.txt](https://github.com/Ajit1279/GCPStaging/blob/main/pubsub/requirements.txt) in pubsub directory 

    - Ensure to **create these files in cloudshell where you are running these commands** 

    - Deploy using the below command

            gcloud functions deploy notify_pubsub \
            --entry-point=notify_pubsub \
            --runtime=python310 \
            --trigger-resource=airflow-pubsub-bucket \
            --trigger-event=google.storage.object.finalize \
            --source=/home/gcpajitk/pubsub

    - It may take at least 10-15 mins for the function to get deployed. If it returns error, try deploying again by removing extra spaces from the command. If the error persists, troubleshoot it further.

      ![image](https://github.com/user-attachments/assets/967d8976-150e-410c-9e27-ea8fa22965c7)

      ![image](https://github.com/user-attachments/assets/200dcb53-a2b6-46ad-99e6-ee67305946b6)

  - Now let's upload a dummy file (readme.md) to the cloud storage bucket and see if Cloud function is triggered

      ![image](https://github.com/user-attachments/assets/dfd2447f-73a2-4079-b9d3-b683a289b837)

  - Thus, Cloud Storage Bucket, Pub/Sub and Cloud Function set-up is complete.
---------------------------------------------------------------
- Let's set-up Airflow now
  - Create [etl_pipeline.py](https://github.com/Ajit1279/GCPStaging/blob/main/dags/etl_pipeline.py) in dags directory. This is the main dag
    
  - Create [extract.py](https://github.com/Ajit1279/GCPStaging/blob/main/dags/extract.py) to extract data from Cloud Storage
   
  - Create [transform.py](https://github.com/Ajit1279/GCPStaging/blob/main/dags/transform.py) for cleaning & processing the data from extracted files
  
  - Create [load.py](https://github.com/Ajit1279/GCPStaging/blob/main/dags/load.py) to load data into BigQuery

  - Install required packages in composer (Composer does not automatically install new dependencies when you upload a file to the DAGs folder)

         gcloud composer environments update composer-env \
          --update-pypi-package apache-airflow-providers-google \
          --location us-central1
    
  - Create a new service account composer-sa, since Composer interacts with GCS, Pub/Sub, BigQuery, and Cloud Functions. Go to iAM, Service Account and grant following roles to it: Composer Worker, Storage Admin, Pub/Sub Editor, BigQuery Admin, Cloud Functions Invoker

  - Go to Composer and click on "Create Environment" >> Composer 3 Environment and follow below screenshots. Keep the remaining options as default.

      ![image](https://github.com/user-attachments/assets/ee0d2c98-531e-4f5b-acd1-054c395cd28b)

      ![image](https://github.com/user-attachments/assets/9b145e08-c6f8-474a-bf9a-6aca3ba6ce87)
  
  - Click on Create. It may take several minutes. It'll look something like this

      ![image](https://github.com/user-attachments/assets/41b5dfaa-7789-458f-b956-af3ff6109bec)

  - Click on the DAGs folder icon highlighted in yellow background above

      ![image](https://github.com/user-attachments/assets/cec994f7-5ce8-49ca-93e3-eccb48fd10f4)

  - Upload etl_pipeline.py, extract.py, transform.py and load.py in the dags folder highlighted above

       ![image](https://github.com/user-attachments/assets/3cb18586-76d2-4434-a155-336b05982652)

  - To test if it's working, click on the Airflow webserver url (highlighted below)

      ![image](https://github.com/user-attachments/assets/981ca54d-0825-4dba-9b53-be629936cf82)

  - It'll open a UI like shown below. Click on the Play button highlighted below

      ![image](https://github.com/user-attachments/assets/a87a0a7c-3d72-4f57-927b-824824f34650)

  - It displays the status

      ![image](https://github.com/user-attachments/assets/662bd182-bcfa-425b-a6b2-03242ec991f0)

  - It failed considering there's no message in the pub/sub

      ![image](https://github.com/user-attachments/assets/04996d6d-8d58-4adc-ae1b-fadb30fa5289)

----------------------------------------------------------------------
- **Execution**
  - Now let's upload a file to Cloud Storage Bucket

     ![image](https://github.com/user-attachments/assets/6ad6aeb4-1eae-4575-abff-74833e75351f)

  - Go to the Console >> Cloud Functions >> Logs Tab. It shows that Cloud Function successfully published the message to Pub/Sub

      ![image](https://github.com/user-attachments/assets/1bf9de67-4f45-482a-88af-2877988608d1)

  - Run the command in the Cloudshell (Nothing is appearing in Logs explorer). 

            gcloud pubsub subscriptions pull etl-subscription --auto-ack

      ![image](https://github.com/user-attachments/assets/1272e9ec-c560-4b47-afb0-092d4dcfcf28)

  - This shows the message was publised to pub/sub.
  
  - Now let's check if Airflow is processing these messages:

  - Open the Airflow UI >> Browse >> DAG Runs >> Search >> Add Filter >> Dag Id and enter "contains" "etl_pipeline" as shown in screenshots below

      ![image](https://github.com/user-attachments/assets/2e9b2aaf-8134-4593-a852-65e4b6c098d7)

      ![image](https://github.com/user-attachments/assets/3ca89e3f-d7fc-41fa-9020-3909b281da92)

  - It shows that the DAG has failed.

      ![image](https://github.com/user-attachments/assets/3370f6b5-a4d1-475b-ac25-f6525cecf873)

  - To troubleshoot, click on the latest run, it shows the below (porcess_pubsub_message failed)

      ![image](https://github.com/user-attachments/assets/d35cb3cb-91bb-47ae-8806-0bcbd66d3933)

  - Click on the related logs

      ![image](https://github.com/user-attachments/assets/d72320f1-7f11-4779-a9aa-76d26eec6147)

      
  - sd
  - sd
  - s
  - ds
  - ds
  - ds
  - d
  - sd
  -  
