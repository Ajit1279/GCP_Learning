- **Reference:** https://cloud.google.com/functions/docs/configuring/secrets

- **Basics:**
  - Function can access secrets in same project as function or in another project
  - Secrets can be made available to your function in below ways:
    - **Mounting the secret as a volume**:
      - Function accesses the secret value from Secret Manager each time the file is read from disk.
      - Good strategy if you want to reference the latest version of the secret instead of a pinned version of the secret.
      - Also works well if you plan to implement secret rotation.
    - **Passing as an environment variable**
      - Environment variable values are resolved at instance startup time
      - It's recommended referencing a pinned version of the secret instead of referencing the latest version of the secret in such cases.   
  
- **Step-by-step instructions**
  - Enable the Secret Manager API if not done already
  - **Create a secret:** gcloud secrets create my-cldfun-secret --replication-policy="automatic"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/03eeda9b-48c1-4da0-ab70-de7e3479ad9f)

  - **Granting access to secret:**
    - The function's runtime service account must be granted access to the secret.
    - The App Engine default service account can be used or you can [create your service account](https://cloud.google.com/iam/docs/service-accounts-create)
      gcloud iam service-accounts create my-cldfun-secret-sa@myprojec21.iam.gserviceaccount.com   
       --description="Cloud Function Service Account for Secret Manager"  
       --display-name="cldfun-secret-servacct"
    - It gave an error in CLI, but it was created successfully in Console
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1eb6f5c4-1f62-488e-977c-d6d97f0949cc)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/18b3241c-a03e-4233-a537-656947c5ff43)
 
  - **Assign a "secret accessor" role to this sevice account.**
    gcloud projects add-iam-policy-binding myprojec21 --member="serviceAccount:my-cldfun-secret-sa@myprojec21.iam.gserviceaccount.com" --role="roles/secretmanager.secretAccessor"
  
  - **Let's access the secret as volume mounted (file).** Create a unused, non-system directory: e.g. /mount/secretdir and create a file cldfunsecret in it.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7bf5f154-dc19-4c49-bede-9cd5d4a80def)

  - **Make secret accessible to function:**
    deploy secretaccess-http-function \
    --gen2 \
    --runtime=nodejs20 \
    --region=us-central1 \
    --source=. \
    --entry-point=getSECRET \
    --trigger-http \
    --allow-unauthenticated \
    --set-secrets '/home/ajit1279_aiml/mount/secretdir/cldfunsecret=my-cldfun-secret:latest'     

  - It gave an error message:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/aad2446a-f4c8-42dd-a76f-880fb9beb0b5)

  - Something wrong with my gcloud shell, so deployed manually through console
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/24f34b95-799d-4ba5-a21b-81b058688b05)

  - When clicked on the [url](https://us-central1-myprojec21.cloudfunctions.net/secretaccess-http-function), it gave an error:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/326a234a-2f05-4f54-a6e3-0678ff1e28c0)

- df
- df
- df
- df
- d
- fd
- f
- df
- df
- df
- d
