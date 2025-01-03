- Reference: https://www.youtube.com/watch?v=14x4XwEwiDs&list=PLLrA_pU9-Gz0oXg8ccnHjfowKXxxud8P9&index=5

 ![image](https://github.com/user-attachments/assets/db00a2b4-2b07-453c-a7fa-7ce4144f0d19)

- Install Jenkins from Google Marketplace
  - Specify the service account name, source IP ranges for HTTP traffic (0.0.0.0/0)

     ![image](https://github.com/user-attachments/assets/8510ec9d-17f7-4958-8436-466ce9f09deb)

     ![image](https://github.com/user-attachments/assets/cccb6d8c-5795-42fb-9185-69f3170edbe5)

- Click on the Site url in the above screenshot and enter the user id and password

    ![image](https://github.com/user-attachments/assets/9c60dc97-4165-4b7b-a5d8-2c26855df79b)

- We've to install few plugins in Jenkins on the path Manage Jenkins >> Plugins >> available plugins
  - pipeline plugins: pipeline, Pipeline API, Pipeline SCM, Pipeline Job, Pipeline Groovy

      ![image](https://github.com/user-attachments/assets/85b4f659-0318-49fd-b600-6181100d4b85)

  - Git plugins: Git, GitHub API, GitHub

  - Restart the Jenkins and sign-in again.

      ![image](https://github.com/user-attachments/assets/57cf140a-43c1-42c9-8ad6-c318a6e03ec5)


- To install Terraform on the "Jenkins-1-VM" created by the Jenkins deployment, SSH into VM and check the OS and it's version

        lsb_release -a

     ![image](https://github.com/user-attachments/assets/0cbda99f-5298-4a12-ac95-9e29b7539b19)

- Install terraform by following [instructions](https://developer.hashicorp.com/terraform/install#linux), type y to continue installation

      wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
      sudo apt update && sudo apt install terraform

- Check the terraform version

      terraform --version

    ![image](https://github.com/user-attachments/assets/8a60083a-1344-4fc6-b650-abeba1b49d0b)

- Now integrate Github repository. My repository is public, but private repository can also be integrated as shown in the demo
  - Create simple [main.tf](https://github.com/Ajit1279/GCP_Learning/blob/main/250102_DevOpsProject/Jenkins_Terraform/main.tf) in the repo you want to integrate

  - Create [Jenkinsfile](https://github.com/Ajit1279/GCP_Learning/blob/main/250102_DevOpsProject/Jenkins_Terraform/Jenkinsfile)

  - We'll also need provide the Service Account access to our github repository. Go to Console >> iAM & Admin >> Service Account

  - Manage Permission of the SA jenkins-sa@devops-446607.iam.gserviceaccount.com. Since we are only creating Storage Bucket, we'll assign related permissions only (i.e. Storage Admin to keep this demo simple)

  - Also create a key for the service account Click on Service Account >> Keys tab >> Add Key >> Create new Key >> Select Key Type as "JSON" >> Click on "Create". A file will be downloaded to your local machine.

     ![image](https://github.com/user-attachments/assets/1920c306-44e7-4c01-a966-631e73f45888)

  - Now go to Jenkins >>  Manage Jenkins >> Credentials in Security section >> Click on global under domains >> Add Credentials

     ![image](https://github.com/user-attachments/assets/70668106-fc6a-47d3-8f7c-45f2824b1c89)

  - In the kind, select "Secret File", Select Scope as Global (Jenkins, nodes, items....). Upload the file. Mention id as "gcp-key" which we have used in Jenkinsfile as well. Click on Create

     ![image](https://github.com/user-attachments/assets/d67462b0-694f-4da6-90a9-f2442858ae85)

     ![image](https://github.com/user-attachments/assets/ad6f99b9-d3af-4d7e-b4f1-95389466d298)

  - Now we'll have to create github credentials. Click on your "github profile" in top right hand corner >> setting >> Developer Setting >> personal access tokens >> Classic Tokens >> Generate New Token (classic)

     ![image](https://github.com/user-attachments/assets/6d280e13-a817-4892-bd6f-39991f60d031)

     ![image](https://github.com/user-attachments/assets/19106209-8399-4c38-8267-c3b255097aba)

     ![image](https://github.com/user-attachments/assets/4e0447bd-ff50-4b9d-81a4-b39f2ee516b3)

  - Provide Expiration as 7 days (as this is just demo). Check on "Repo" to grant repo level permissions only. Click on "Generate Token". Remeber to copy it immediately.

     ![image](https://github.com/user-attachments/assets/82ce67e7-f642-4df5-b1ac-881afc4919ee)

     ![image](https://github.com/user-attachments/assets/2b2e0ec4-62f4-4513-952c-294abb1f5c75)

  - Go back to Jenkins again to create one more secret. Click on "Add Credential". Select "Secret Text" , paste the git token generated in above step and mention id as "git-token" (which we have mentioned in Jenkinsfile) and click on Create

     ![image](https://github.com/user-attachments/assets/321c7b8e-9295-49a3-9536-c6db98f610db)

     ![image](https://github.com/user-attachments/assets/3ec73010-a7e2-449e-9a93-410aa78b00f5)

- Now create a Jenkins pipeline. Go to Dashboard >> Click on New Item. Specify "gcp-jenkins-tf-demo" and select "pipeline" and click OK
      
- In the next screen, scroll down to "Pipeline" section. As we are using github as our source, select "Pipeline script from SCM", SCM as Git, In the repository url mention the repository path (not the folder path) i.e. https://github.com/Ajit1279/GCP_Learning.git. Check if the filename in "Script Path" field

- To test click on "build now". However the Jenkins build job failed.

   ![image](https://github.com/user-attachments/assets/f3e90422-d202-4cce-b0a2-76e9f08f2588)

- This is most likely due to the error while configuring the git repo, which also contains the folders

   ![image](https://github.com/user-attachments/assets/36f82b6e-b962-4fbe-84e2-6dddaa609d91)

- Let's try by changing the branches to main instead of master, as master branch does not exist in git.

   ![image](https://github.com/user-attachments/assets/5f871b9e-8c3b-4454-a750-f117084b04b9)

- Now it failed with different error. It's not able to locate the Jenkins file.

   ![image](https://github.com/user-attachments/assets/d13ff64a-c7d7-4357-a1c1-5d68e5517ca6)

- Let's try changing the path of Jenkins file in the pipeline configuration as shown below

   ![image](https://github.com/user-attachments/assets/abcd7d48-706f-446d-ab24-cf8cf872bc17)

- It returned the similar error

   ![image](https://github.com/user-attachments/assets/816c06b4-f0bb-4f08-b2a0-188c8ba3d4d8)

- Let's try to "move" the files in the parent git repo and change the script path as shown below

   ![image](https://github.com/user-attachments/assets/7f7efa2e-dbe1-4051-ad27-5695f4f22bb9)

- The errors encountered previously were resolved this time and build progressed a bit until it hit timeout error

   ![image](https://github.com/user-attachments/assets/0bdf21e5-2749-4899-a931-8cbf6d0dd785)

- Let's create a new git repository and retry. 
- 
-   
- 

    


     
- 
-  
