- Reference: https://cloud.google.com/architecture/cicd-pipeline-for-data-processing
- Basics:
  - Ensures **high quality, maintainability, and adaptability of the data processes and workflows**.
  - **Methods that you can apply**:
    - **Version control** of source code.
    - **Automatic building, testing, and deployment of apps**.
    - **Environment isolation and separation from production**.
    - **Replicable procedures for environment setup.**
  - To completely separate the environments, you need multiple Cloud Composer environments created in different projects
  -  

- Reference Architecture
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f7a871bc-a00f-45fd-88ad-e554b37afbf4)

  - 1. A developer commits code changes to the Cloud Source Repositories.
  - 2. Code changes trigger a test build in Cloud Build.
  - 3. Cloud Build builds the self-executing JAR file and deploys it to the test JAR bucket on Cloud Storage.
  - 4. Cloud Build deploys the test files to the test-file buckets on Cloud Storage.
  - 5. Cloud Build sets the variable in Cloud Composer to reference the newly deployed JAR file.
  - 6. Cloud Build tests the data-processing workflow Directed Acyclic Graph (DAG) and deploys it to the Cloud Composer bucket on Cloud Storage.
  - 7. The workflow DAG file is deployed to Cloud Composer.
  - 8. Cloud Build triggers the newly deployed data-processing workflow to run.
  - 9. When the data-processing workflow integration test has passed, a message is published to Pub/Sub which contains a reference to the latest self-executing JAR (obtained from the Airflow variables) in the message’s data field.     


  - [**DAG (Directed Acyclic Graph):**](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html)
    - Core concept of Airflow
    - Collecting Tasks together, organized with dependencies and relationships to say how they should run.
    - e.g. four Tasks - A, B, C, and D - and dictates the order in which they have to run
    - It will also say how often to run the DAG - maybe “every 5 minutes starting tomorrow”, or “every day since January 1st, 2020”.
   
  - [Deploy a CI/CD Pipeline](https://cloud.google.com/architecture/cicd-pipeline-for-data-processing/deployment)
    - Configure the Cloud Composer environment.
    - Create Cloud Storage buckets for your data.
    - Create the build, test, and production pipelines.
    - Configure the build trigger. 
