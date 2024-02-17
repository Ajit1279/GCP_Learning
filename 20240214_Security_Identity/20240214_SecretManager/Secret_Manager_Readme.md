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

  - **[Manage Access to secrets](https://cloud.google.com/secret-manager/docs/manage-access-to-secrets)**
    - Requires the Secret **Manager Admin role (roles/secretmanager.admin)** on the secret, project, folder, or organization.
    - Let's achieve it in a [Python program](https://github.com/Ajit1279/GCP_Learning/blob/main/20240214_Security_Identity/20240214_SecretManager/20240217_ManageAccess/Python/main.py)
      - Open CLI and check the python version: pip3 --version (if python dev env is not set-up already, follow [these steps](https://cloud.google.com/python/docs/setup#linux))
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/38846b01-0790-49b7-a057-59229c512110)

      - Set-up [Secret Manager client libraries](https://cloud.google.com/secret-manager/docs/reference/libraries#client-libraries-install-python)
      - Although you can use Google Cloud APIs directly by making raw requests to the server, client libraries provide simplifications that significantly reduce the amount of code you need to write. 
      - Run the command: pip install google-cloud-secret-manager
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e34bed21-d0ff-485a-8137-641cc0dadb19)

      - Set-up Authentication: To authenticate calls to Google Cloud APIs, client libraries support [Application Default Credentials (ADC)](https://cloud.google.com/docs/authentication/application-default-credentials);
      
      - With ADC, you can make credentials available to your application in local development or production, without needing to modify your application code.

      - Create your credentials file: gcloud auth application-default login
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fb697bb9-2ba8-49eb-a009-ff879bbd7efe)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/992bb6f9-8c07-4e7c-aad9-fc82d1cfc069)

 
  - Use the client library in Python program. ([reference](https://github.com/GoogleCloudPlatform/python-docs-samples/blob/HEAD/secretmanager/snippets/quickstart.py))

  - Refer the [Python program](https://github.com/Ajit1279/GCP_Learning/blob/main/20240214_Security_Identity/20240214_SecretManager/20240217_ManageAccess/Python/main_useclintlibry.py) for details
      
  - Run python program using command: python main.py
      
  - To grant access, refer the [Python program](https://github.com/Ajit1279/GCP_Learning/blob/main/20240214_Security_Identity/20240214_SecretManager/20240217_ManageAccess/Python/main_grantaccess.py)
      
  - Encounterd error below:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/34703640-7bab-4ef5-84c0-7563ef504d01)

  - Added below code to resolve the error
        import argparse
        from google.iam.v1 import iam_policy_pb2  # type: ignore
      
  - Then the code ran successfully without any error, but it didn't display message "Updated IAM policy on"
  - So let's go to iAM and find out which principles have role roles/secretmanager.secretAccessor, but no changes appeared
  - **This needs to be investigated further** 
    
  - To revoke access, run the [python program](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240214_SecretManager/20240217_ManageAccess/Python)
      
  - It ran successfully

  - sd
  - sd
  - s
  - ds
  - ds
  - ds
  - sd
  - sd
  - sd
  - s
  - ds
  - ds
  - d
  - sd
  - sd
  - s
  - ds
