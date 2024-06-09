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
 
       
      - 
   
      
