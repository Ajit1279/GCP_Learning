- References:
  - [Create Encryption Keys with Cloud KMS](https://cloud.google.com/kms/docs/create-encryption-keys)
  - [How to encrypt data and manage encryption keys using Key Management Service (KMS).](https://www.cloudskillsboost.google/focuses/1713?parent=catalog)
  - [CodeLabs: Encrypt and Decrypt data with Cloud KMS](https://codelabs.developers.google.com/codelabs/encrypt-and-decrypt-data-with-cloud-kms#0)

- **Getting Started with Cloud KMS**
  - Allows you to **create, import, and manage cryptographic keys**
  - CryptoKeys belong to KeyRings, and KeyRings belong to Projects, a user with a specific role or permission at a higher level in that hierarchy inherits the same permissions on the child resources.
  - For example, a user who has the role of Owner on a Project is also an Owner on all the KeyRings and CryptoKeys in that project.
  - Similarly, if a user is granted the **cloudkms.admin** role on a KeyRing, they have the associated permissions on the CryptoKeys in that KeyRing.
  - Without the **cloudkms.cryptoKeyEncrypterDecrypter permission**, the authorized user will not be able to use the keys to encrypt or decrypt data.
    
  - KMS perform cryptographic operations in a single centralized cloud service using:
    - **Cloud HSM**
    - **Cloud External Key Manager**
    - **[Customer-Managed Encryption Keys (CMEK)]**(https://github.com/Ajit1279/GCP_Learning/blob/main/20240214_Security_Identity/20240214_SecretManager/Secret_Manager_Readme.md)  
  - 
- **Step-by-step instructions**
  - **Enable Cloud KMS API**: **gcloud services enable cloudkms.googleapis.com**
  - **To encrypt and decrypt content you will need a Cloud KMS key, which is part of a key ring.**
    - Create a key ring named test-key-ring: Key Rings are useful for grouping keys e.g. by environment (test, staging, prod) 
      **gcloud kms keyrings create "test-key-ring" \
      --location "global"**

    - Create a Key named test-key
      **gcloud kms keys create "test-key" \
      --location "global" \
      --keyring "test-key-ring" \
      --purpose "encryption"**

    - List the keys you just created
      **gcloud kms keys list \
    --location "global" \
    --keyring "test-key-ring"**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/bb0af12a-36cb-40d9-906d-c7a625c3db53)

  - **Encrypt Data**:
    - Store some text to be encrypted in a file called "mysecret.txt":  **echo -n "I want to encrypt this text" > mysecret.txt**
    - Encrypt using below command:
      **gcloud kms encrypt \
        --location "global" \
        --keyring "test-key-ring" \
        --key "test-key" \
        --plaintext-file ./mysecret.txt \
        --ciphertext-file ./mysecret.txt.encrypted**

    - Output of **cat mysecret.txt.encrypted**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5c136658-361c-4bd9-9c04-cc96353179d1)

  - **Decrypt Data**:
    - Enter the command:
      **gcloud kms decrypt \
        --location "global" \
        --keyring "test-key-ring" \
        --key "test-key" \
        --ciphertext-file ./mysecret.txt.encrypted \
        --plaintext-file ./mysecret.txt.decrypted**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8f00451c-2e99-4d9b-bf9e-97f424e81b8e)

=============
Clean-up
=============
- To avoid charges
  **gcloud kms keys versions destroy 1 \
    --location "global" \
    --keyring "test-key-ring" \
    --key "test-key"** 

=========
Encrypt and Decrypt data in Cloud Storage Bucket
===================
- **Create a Cloud Storage bucket**:
    BUCKET_NAME="mykmstestbucket"
    gsutil mb gs://${BUCKET_NAME}
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/149c1272-ee4a-4d2e-b038-a3372650b44a)

- **Checkout the Data**
  - [Enron Corpus](https://en.wikipedia.org/wiki/Enron_Corpus) is large dataset of over 600,000 emails.
  - This data has been copied to the Cloud Storage bucket gs://enron_emails/.
  - Download one of the source files locally: **gsutil cp gs://enron_emails/allen-p/inbox/1. .**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a70febcf-3732-4ff2-acfa-9baf41f76884)
 
  - Verify the email text: **tail 1.**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a16e9e72-a03d-4b30-bf86-d75f035a11d2)
    
- **Create Key Ring and Crypto Key**
  -  Type the following: **KEYRING_NAME=test-bucket-keyring CRYPTOKEY_NAME=test-bucket-key**
  -  Create a Key Ring: **gcloud kms keyrings create $KEYRING_NAME --location global**
  -  Next, create a key using this key ring:
      **gcloud kms keys create $CRYPTOKEY_NAME --location global \
      --keyring $KEYRING_NAME \
      --purpose encryption**

- **Encrypt the data**
  - Take the contents of the email you looked at earlier and base64 encode it by running the following: **PLAINTEXT=$(cat 1. | base64 -w0)** 
  - Base64 encoding allows binary data to be sent to the API as plaintext. This command works for images, videos, or any other kind of binary data.
  - Using the encrypt endpoint, you can send the base64-encoded text you want to encrypt to the specified key.
    **curl -v "https://cloudkms.googleapis.com/v1/projects/$DEVSHELL_PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:encrypt" \
    -d "{\"plaintext\":\"$PLAINTEXT\"}" \
    -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
    -H "Content-Type: application/json"**

  - The response will be a JSON payload containing the encrypted text in the attribute ciphertext.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/15286d44-41cd-4f74-8f93-5ab923a732b5)

  - Now that your data is encrypted, you can save it to a file and upload it to your Cloud Storage bucket.
  - To grab the encrypted text from the JSON response and save it to a file, use the command-line utility jq.
  - The response from the previous call can be piped into jq, which can parse out the ciphertext property to the file 1.encrypted.
  - Run the following: 
      **curl -v "https://cloudkms.googleapis.com/v1/projects/$DEVSHELL_PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:encrypt" \
      -d "{\"plaintext\":\"$PLAINTEXT\"}" \
      -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
      -H "Content-Type:application/json" \
      | jq .ciphertext -r > 1.encrypted**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/30b7a929-c5c0-474a-83c8-d8722717c7e6)

  - To verify the encrypted data can be decrypted, call the decrypt endpoint to verify the decrypted text matches the original email.
  - **NOTE:** The encrypted data has information on which CryptoKey version was used to encrypt it, so the specific version is never supplied to the decrypt endpoint.
    **curl -v "https://cloudkms.googleapis.com/v1/projects/$DEVSHELL_PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:decrypt" \
      -d "{\"ciphertext\":\"$(cat 1.encrypted)\"}" \
      -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
      -H "Content-Type:application/json" \
      | jq .plaintext -r | base64 -d**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6c00b3eb-43b7-4eaa-9a7e-b4f03465a251)

- **Upload Enrypted data to Cloud Storage Bucket**
  - Now that you have verified the text has been encrypted successfully, upload the encrypted file to your Cloud Storage bucket: **gsutil cp 1.encrypted gs://${BUCKET_NAME}**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b36aa11b-4e35-4dc0-ba71-4f55d5069c99)

- **Configure IAM permissions**   
  - There are **two major permissions to focus on in KMS**:
    - **Permissions which allows a user or service account to manage KMS resources (cloudkms.admin)** i.e. allows anyone with the permission to create KeyRings and create, modify, disable, and destroy CryptoKeys.
    - **Permissions which allows user or service account to use keys to encrypt and decrypt data (cloudkms.cryptoKeyEncrypterDecrypter)** to call the encrypt and decrypt API endpoints.

  - To get current authorised user, run the command: USER_EMAIL=$(gcloud auth list --limit=1 2>/dev/null | grep '@' | awk '{print $2}')
  - Assign that user ability to manage KMS resources:
      gcloud kms keyrings add-iam-policy-binding $KEYRING_NAME \
        --location global \
        --member user:$USER_EMAIL \
        --role roles/cloudkms.admin
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5ec5390d-e2c3-4e18-a5ef-6f4f4547a068)

  - Assign the user ability to encrypt and decrypt data:
    gcloud kms keyrings add-iam-policy-binding $KEYRING_NAME \
    --location global \
    --member user:$USER_EMAIL \
    --role roles/cloudkms.cryptoKeyEncrypterDecrypter
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/63256550-055d-4dc2-80b1-3b0b08c32a2f)
   
- **Back up data on the command line**
  - For this example, **copy all emails for allen-p, encrypt them, and upload them to a Cloud Storage bucket.**: gsutil -m cp -r gs://enron_emails/allen-p .
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c2bbb6ed-f47f-4132-83ac-197d6a5f1d02)

  - Now copy and paste the following into Cloud Shell to back up and encrypt all the files in the allen-p directory to your Cloud Storage bucket:
    **MYDIR=allen-p
    FILES=$(find $MYDIR -type f -not -name "*.encrypted")
    for file in $FILES; do
    PLAINTEXT=$(cat $file | base64 -w0)
    curl -v "https://cloudkms.googleapis.com/v1/projects/$DEVSHELL_PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:encrypt" \
      -d "{\"plaintext\":\"$PLAINTEXT\"}" \
      -H "Authorization:Bearer $(gcloud auth application-default print-access-token)" \
      -H "Content-Type:application/json" \
    | jq .ciphertext -r > $file.encrypted
  done
  gsutil -m cp allen-p/inbox/*.encrypted gs://${BUCKET_NAME}/allen-p/inbox**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/521d6976-03f8-4a4f-8250-c83b54357956)

  - To find the files, go to Navigation menu > Cloud Storage > Buckets > YOUR_BUCKET > allen-p > inbox. You should see something like this:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1c397e45-0e7f-4b2a-937b-98405099f17c)

- **View Cloud Audit Logs**
  - Google Cloud Audit Logging consists of two log streams. Admin Activity and Data Access, which are generated by Google Cloud services to help you answer the 
    question "who did what, where, and when?" within your Google Cloud projects.
  - To view the activity for any resource in KMS, go to **Navigation menu > Cloud Overview > Activity** tab. This will take you to the **Cloud Activity UI** and   
   then **click on View Log Explorer, Select Cloud KMS Key Ring as the Resource** Type and you should see the creation and all modifications made to the KeyRing. 
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7dd87f09-fd6f-491f-bad0-c99242305ff7)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/00b5988c-30ea-443b-a44e-25640cf0beaa)
  
============
Cleanup
==========
- 
