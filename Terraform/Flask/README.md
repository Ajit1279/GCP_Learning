# Reference Google Documentation at: https://cloud.google.com/docs/terraform/get-started-with-terraform
## https://cloud.google.com/docs/terraform/get-started-with-terraform


**1. Create a new project** named terraform-project so that all the resources can be deleted when work completed
But before that ensure to use correct GCP id in cloud SDK

gcloud auth login gcpajit80
gcloud projects create --name="terraform-project" answer the prompt as "Y" and new project will be created.

**2. Compute Engine Permissions** (Cloud SDK???)
compute.instances.*
compute.firewalls.*

**3. Enable Compute Engine API** (cloud SDK????)
Go to console ---> project ---> APIs and Services ---> Enable APIs & Services ---> Search for "Compute Engine API" and hit enter

**4. Start a cloudshell** (It is  Compute Engine virtual machine. Terraform is integrated with Cloud Shell, and Cloud Shell automatically authenticates Terraform, letting you get started with less setup.)
i) Create a directory called tf-tutorial and go to that directory: mkdir tf-tutorial && cd tf-tutorial
ii) Create main.tf terraform file in it using nano editor: nano main.tf 

**5. Include the following commands in Terraform**
i) Create network and subnetwork
ii) Create VM with the required configurations

**6.Please enable bunch of APIs before proceeding**
i) Cloud Resource Manager API
ii) IAM Service Account Credentials API
iii) Cloud Key Management Service (KMS) API


**7.** Type **terraform init** in cloud shell to build the terraform directory and add necessary plugins. 
Once run successfully, the command will display **Terraform has been successfully initialized!**

**8.** Type **terraform plan** 
i) It verifies that the syntax of main.tf is correct
ii) It shows preview of the resources that will be created

**9.** Type **terraform apply**
This will initiate creating the resources. During the process you might encounter below error:
 Error: googleapi: Error 403: Permission denied on Cloud KMS key. Please ensure that your Cloud Storage service account has been authorized to use this key., forbidden
│ 
│   with google_storage_bucket.default,
│   on main.tf line 125, in resource "google_storage_bucket" "default":
│  125: resource "google_storage_bucket" "default" {
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/24341205-3054-4108-97cd-3c4f0b049f76)

**To resolve this run the below command:**
_gcloud projects add-iam-policy-binding tf-proj-21 \
    --member=serviceAccount:"service-285839563305@gs-project-accounts.iam.gserviceaccount.com" \
    --role=roles/cloudkms.cryptoKeyEncrypterDecrypter_
References: https://github.com/googleapis/nodejs-storage/issues/1254
https://stackoverflow.com/questions/42564112/adding-roles-to-service-accounts-on-google-cloud-platform-using-rest-api

**10. Run a webserver on Google Cloud**
i) Go to vm instances page and ssh into the machine
ii) In the **SSH browser terminal** enter command *nano app.py*
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_cloud():
  return 'Hello Cloud!'

app.run(host='0.0.0.0')

iii) Then **run the server** using the command **python3 app.py**. It'll give the below output confirming server is running
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e3025375-5723-4069-8850-f2432586bba5)

iv) Open another SSH window for the same VM and enter command: **curl http://0.0.0.0:5000** It will display the below:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b95ab4f2-8777-4597-a752-65640273abb4)

v) Alternatively you can run it in the browser using external IP address: http://IP_ADDRESS:5000
**http://35.230.45.172/:5000**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6dcb5832-8289-41ef-a13f-5bc7cd66acec)

**11** Finally destroy the resources using **terraform destroy** command
