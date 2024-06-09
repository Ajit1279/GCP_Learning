- Reference: https://cloud.google.com/dataform/docs/repositories

- **Introduction**
  - Each Dataform **project** is **stored in a repository**, which **houses a collection of JSON configuration files, SQLX files, and JavaScript files**.
  - It contains:
    - **Config files:** JSON or SQLX files which contain **general configuration, execution schedules, or schema** for **creating new tables and views**.
    - **Definitions:** **SQLX and JavaScript files** that **define new tables, views, and [additional SQL operations](https://cloud.google.com/dataform/docs/custom-sql)** to run **in BigQuery**.
    - [**Includes:**](https://cloud.google.com/dataform/docs/reuse-code-includes) **JavaScript files** where you can **define variables and functions** to use in your project.
  - Each repository is **connected to a service account** (at the time of creation or can be added later).


- **Steps**
  - [**Create a repository**](https://cloud.google.com/dataform/docs/create-repository) 
    - Go to Console >> BigQuery >> Dataform >> Create Repository

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8be018b7-ef2e-4678-92fe-5b37ecda1e95)

    - Fill up the details:

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5cf056f1-db69-4825-b77b-8ab273715e35)

    - A message is displayed once the repository is created

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a03c9610-e82c-406d-bcb7-a4f4c90981e5)

  - [**Connect to a third-party Git repository**](https://cloud.google.com/dataform/docs/connect-repository)
    - Grant your id the Dataform admin role
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5b93e141-f3da-4672-8736-b6c65b33028e)

    - [Authenticate a remote repository through HTTPS](https://cloud.google.com/dataform/docs/connect-repository#authenticate_a_remote_repository_through_https)
      - Create a Secret Manager secret with a [personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#about-personal-access-tokens), and sharing the secret with your Dataform service account.
      - Dataform then uses the access token to sign in to your Git provider to commit changes on behalf of the developers.
      - Dataform makes these commits using the developer's Google Cloud email address so you can tell who made each commit.
      - To authenticate a GitHub repository, create a classic personal access token or a [fine-grained personal access token](To authenticate a GitHub repository, create a classic personal access token or a fine-grained personal access token) (Recommended). Please note it down immediately and copy to a file on your local machine which will need to be uploaded to secret manager in the next step
      - Enable the Secret Manager API to create a secret containing a personal access token for connecting to your Git provider.
   
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4e421f59-4c62-40e5-9f4f-ea900f2570bb)
 
       
      - Grant secretmanager.secretAccessor role to your dataform service account (but not able to find the default service account created at the time of dataform creation: service-1046191342666@gcp-sa-dataform.iam.gserviceaccount.com). LEt's troubleshoot this later.
     
      - Now let's connect with the git repository
   
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8ef56223-ee6a-460e-a600-c729ff10afce)
 

      - Entered the details to link the repository
   
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d8cf7879-2a7e-469b-9a44-09f3f8e1dfed)


      - It gave an error message:
   
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4c2ef3fc-749e-4882-bda1-d3d283919021)


      - So created a new service account manually and updated the Dataform, but the error persists
   
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9f859378-25e3-40fc-8b09-1ac5dd6cca09)


      - Also verified that the secret token exists

        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/249dcc5f-43b1-4748-9e2a-9eb5cf3c1b6a)


        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fb4ab768-1b45-4a79-98e6-a76629ff5556)

      
      - Click on secret name and then "Permissions" >> Grant Access

        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/83cbfa2f-6cdd-40d9-9c70-9f64e7cf1e74)

      - Add the default service account id and the "Secret Manager Secret Accessor" role.
   
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7d4d71a3-89f5-4f65-93fa-9b9258af1550)

      - "Delete" the connection by going to "Edit Git Connection" button in the Dataform and renter all the values. Woohh!! the connection established successfully

        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/41b2bbb9-c9ee-43eb-8715-6776c38ea90c)

        
        
