- References: https://cloud.google.com/security/products/secret-manager
- Secret Quickstart: https://cloud.google.com/secret-manager/docs/create-secret-quickstart

- **Step-by-step instructions:**
  - **Enable the *Secret Manager API* for the project**
  - **Assign the Secret Manager Admin role** (roles/secretmanager.admin) to default service account on the project, folder, or organization
    - iAM --> Select Service Account --> Click on "Edit Principle"  
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/17d4a8ef-69a9-4267-9d14-dd72e2ecccc5)
    - Click "Add Another Role", search and select "Secret Manager Admin" and Save
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c6b53bf8-6c12-45ac-a116-4c2f1692bd83)

  - **Create a secret and access a secret version**
    - echo -n "my super secret data" | gcloud secrets create my-first-secret \
      --replication-policy="automatic" \
      --data-file=- 
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/aaa55bb5-1d49-499c-9aa9-625eecf195d9)

    - To access the contents of a **specific secret version**: gcloud secrets versions access 1 --secret="my-first-secret"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b365a242-8b10-4b27-8914-052c23d23e50)

    - To access the contents of the **latest secret version**: gcloud secrets versions access latest --secret="my-first-secret"  
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/48d64a82-0ce9-4cbd-a1ae-96cd338ad2be)

  - **Edit a secret**
    - gcloud secrets update my-first-secret --update-labels=mykey=myvalue
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/86430f67-6935-46ca-b3d0-203000057884)

    -  
  - sd
  - sd
  - sd
  - sd
  - s
  - ds
  - ds
  - ds 
