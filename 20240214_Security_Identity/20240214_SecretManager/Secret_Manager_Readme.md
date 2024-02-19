- References: https://cloud.google.com/security/products/secret-manager
- Secret Quickstart: https://cloud.google.com/secret-manager/docs/create-secret-quickstart

- **A secret** is a **project-global object** that **contains a collection of metadata and secret versions**.
- Provides tools for storing, managing, and accessing sensitive data in your applications e.g. replication locations, labels, annotations, and permissions
- By default, secrets stored in Secret Manager are encrypted with Google default encryption.
- The secret versions store the actual secret data, such as an API key or credential. 

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

- **Basic Operations:**
  - [**View Secret Details**](https://cloud.google.com/secret-manager/docs/view-secret-details)
    - The secret stores metadata such as labels and replication, but it does not contain the actual secret
    - Command to list secrets: gcloud secrets list
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/89fb9496-ac14-4b05-99a2-65ba398d30e1)

    - View secret details: gcloud secrets describe create-python-secret
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f1c79aad-c1fa-491d-bf8c-ad0cf4631e2f)

- **[Set-up rotations to secret](https://cloud.google.com/secret-manager/docs/rotation-recommendations)**
  - To rotate a secret, add a new secret version to an existing secret.
  - Three approaches:
    - [Resolve and bind your secret version with your application's release](https://cloud.google.com/secret-manager/docs/rotation-recommendations#approach_1_resolve_during_an_existing_release_process).
    - [Resolve on application startup](https://cloud.google.com/secret-manager/docs/rotation-recommendations#approach_2_resolve_on_application_startup)
    - [Resolve continuously](https://cloud.google.com/secret-manager/docs/rotation-recommendations#approach_3_resolve_continuously)
  - Must configure a Pub/Sub subscriber to receive and act on the SECRET_ROTATE messages.
  - If necessary, implement additional workflows such as adding a new secret version and triggering application deploys.  
 
- **[Enable CMEK for a secret](https://cloud.google.com/secret-manager/docs/cmek)**
  - By default, secrets stored in Secret Manager are encrypted with Google default encryption.
  - CMEK support for Secret Manager lets you have greater control, e.g. configure the Cloud KMS key that protects data at rest in Secret Manager.
  - Before writing a secret version to persistent storage,**Secret Manager encrypts the data** with a unique **Data Encryption Key (DEK).**
  - This DEK is then encrypted with a replica-specific key, called a **Key Encryption Key (KEK)** that is **owned by the Secret Manager service**.
  - **If the KEK is owned by google customers then it's called a CMEK** 
  - CMEK is available only in the Secret Manager v1 API and gCloud.

  - Step by step instructions:
    - **create a service agent identity**.
      - The service identity for Secret Manager, rather than the caller, is responsible for encrypting and decrypting secrets when reading or writing them.
      - The service identity accesses the CMEK key and encrypts or decrypts the secret on your behalf.
      - Run the command to **create a service agent identity**.
      gcloud beta services identity create \
      --service "secretmanager.googleapis.com" \
      --project "myprojec21"

    It displays: Service identity created: service-26438093431@gcp-sa-secretmanager.iam.gserviceaccount.com . Please note this service account for future steps
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ffdb38b8-fa40-4130-a1ec-ad6cc27e6a5d)

    - You will grant this service identity access to the CMEK Cloud KMS keys used to encrypt and decrypt your secrets.
    - Create a **new key ring called secret-manager-cmek**
        gcloud kms keyrings create "secret-manager-cmek" \
      --project "myprojec21" \
      --location "global"
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1cbc5c86-7f83-4974-96de-96539326133e)
 
   
    - Create **new key called my-cmek-key**
      gcloud kms keys create "my-cmek-key" \
      --project "myprojec21" \
      --location "global" \
      --keyring "secret-manager-cmek" \
      --purpose "encryption"

    - Go to Security --> Data Protection ---> Key Management to display all Keys and Key Rings
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ea89e9de-7bb8-434e-9e6b-f0881c681c17)

  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/106e8684-70f9-41d9-b292-f7871a97ab3b)

  
    - Grant the Secret Manager access to encrypt and decrypt (roles/cloudkms.cryptoKeyEncrypterDecrypter) using the CMEK key created above (my-cmek-key). 
         gcloud kms keys add-iam-policy-binding "my-cmek-key" \
         --project "myprojec21" \
         --location "global" \
         --keyring "secret-manager-cmek" \
         --member "serviceAccount:service-26438093431@gcp-sa-secretmanager.iam.gserviceaccount.com" \
         --role "roles/cloudkms.cryptoKeyEncrypterDecrypter"   
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f284342e-2ed5-4516-80a5-41592c9cd21d)

    - **Create a secret with automatic replication. The resource name of the CMEK key is stored as metadata on the secret.**
      gcloud secrets create "my-cmek-secret" \
       --replication-policy "automatic" \
       --kms-key-name "projects/myprojec21/locations/global/keyRings/secret-manager-cmek/cryptoKeys/my-cmek-key" \
       --project "myprojec21"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/49320b75-5a31-4c27-b8d0-2a26536a68af)
 
    - Now, each time a secret version is created in that secret, the secret version's payload is automatically encrypted using the key before being written to 
      persistent storage, as long as the service identity has access to the CMEK key. Let's try it
      
      echo -n "SECRET_DATA" | gcloud secrets versions add "my-cmek-secret" \
      --project "myprojec21" \
      --data-file -
 
    - It displays below message. **Notice that you don't specify the Cloud KMS key's resource name; it is read from the secret's metadata.**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c473c0e3-f4c4-413a-a827-9ebc3e641e21)

    - Access the secret version you just created:
      gcloud secrets versions access "latest" \
      --project "myprojec21" \
      --secret "my-cmek-secret"  
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fb163b3f-af2d-4a99-a093-8b8d006b501c)

  - [**Update CMEK Configuration:**](https://cloud.google.com/secret-manager/docs/cmek#update_cmek_configuration)
    - Run command:
      gcloud kms keys create "my-other-key" \
      --project "myprojec21" \
      --location "global" \
      --keyring "secret-manager-cmek" \
      --purpose "encryption"

    - Run command:
      gcloud kms keys add-iam-policy-binding "my-other-key" \
      --project "myprojec21" \
      --location "global" \
      --keyring "secret-manager-cmek" \
      --member "serviceAccount:service-26438093431@gcp-sa-secretmanager.iam.gserviceaccount.com" \
      --role "roles/cloudkms.cryptoKeyEncrypterDecrypter"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a898a389-54d5-42fd-a4de-d7692f086ffb)

  - **[CMEK with user managed replication](https://cloud.google.com/secret-manager/docs/cmek#user-managed-replication)**    
    - With a user managed replication policy, you control the Google Cloud location where the secret is stored.

    - Secrets with a user managed replication policy must use Cloud KMS keys that map exactly to the locations in which the secret versions are stored.

    - Let's create and store a secret in two separate locations: us-east1, us- central1. Requests to access the secret are routed to one of these locations.

    - Create kms keyrings:
      gcloud kms keyrings create "secret-manager-cmek-east1" \
      --project "myprojec21" \
      --location "us-east1"
 
      gcloud kms keyrings create "secret-manager-cmek-central1" \
      --project "myprojec21" \
      --location "us-central1"

    - Create CMEK Key
       gcloud kms keys create "my-cmek-key-east1" \
        --project "myprojec21" \
        --location "us-east1" \
        --keyring "secret-manager-cmek-east1" \
        --purpose "encryption"


       gcloud kms keys create "my-cmek-key-central1" \
        --project "myprojec21" \
        --location "us-central1" \
        --keyring "secret-manager-cmek-central1" \
        --purpose "encryption"

    - Grant the service identity:
      gcloud kms keys add-iam-policy-binding "my-cmek-key-east1" \
      --project "myprojec21" \
      --location "us-east1" \
      --keyring "secret-manager-cmek-east1" \
      --member "serviceAccount:service-26438093431@gcp-sa-secretmanager.iam.gserviceaccount.com" \
      --role "roles/cloudkms.cryptoKeyEncrypterDecrypter"


      gcloud kms keys add-iam-policy-binding "my-cmek-key-central1" \
      --project "myprojec21" \
      --location "us-central1" \
      --keyring "secret-manager-cmek-central1" \
      --member "serviceAccount:service-26438093431@gcp-sa-secretmanager.iam.gserviceaccount.com" \
      --role "roles/cloudkms.cryptoKeyEncrypterDecrypter"

    - Create a CMEK enabled secret with user managed replication. The resource name of the CMEK key is stored as metadata on the secret.
       cat <<EOF > ./replication-policy.json
{
  "userManaged":{
    "replicas":[
      {
        "location":"us-east1",
        "customerManagedEncryption":{
          "kmsKeyName":"projects/myprojec21/locations/us-east1/keyRings/secret-manager-cmek-east1/cryptoKeys/my-cmek-key-east1"
        }
      },
      {
        "location":"us-central1",
        "customerManagedEncryption":{
          "kmsKeyName":"projects/myprojec21/locations/us-central1/keyRings/secret-manager-cmek-central1/cryptoKeys/my-cmek-key-central1"
        }
      }
    ]
  }
}
EOF
      
    - Then run below command:
      gcloud secrets create "my-ummr-secret" \
      --replication-policy-file ./replication-policy.json \
      --project "myprojec21"

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f0117701-f0c9-4b23-9a9c-8039d183f6f3)

   - Add a new secret version. Notice that you don't specify the Cloud KMS key's resource name; it is read from the secret's metadata.
      echo -n "SECRET_DATA" | gcloud secrets versions add "my-ummr-secret" \
      --project "myprojec21" \
      --data-file -
      
   - Access the secret version you just created.
        gcloud secrets versions access "latest" \
        --project "myprojec21" \
        --secret "my-ummr-secret"

- **[Disable CMEK](https://cloud.google.com/secret-manager/docs/cmek#disable_cmek)**
      gcloud secrets replication update "my-ummr-secret" --remove-cmek \
      --project "myprojec21"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4a0c35ba-78e3-43fc-b789-baeb0c964607)

    
    - Removing CMEK configuration only applies to new secret versions.Existing secret versions are not affected.
    - Existing secret versions can't be accessed if the CMEK key that encrypted it is unavailable.
    - If a key is destroyed, the secret data is unrecoverable.
    
============================================
**Let's use Secret Manager with other GCP products**
============================================
 - [Cloud Functions](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240214_SecretManager/20240219_CldFun)
