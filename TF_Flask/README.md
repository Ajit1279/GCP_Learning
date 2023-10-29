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

**6.** Type **terraform init** in cloud shell to build the terraform directory and add necessary plugins. 
Once run successfully, the command will display **Terraform has been successfully initialized!**
