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
-   
- 

     
- 
-  
