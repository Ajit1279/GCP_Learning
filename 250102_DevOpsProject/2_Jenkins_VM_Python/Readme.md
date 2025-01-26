- This exercise aims at creating a VM on GCP using Terraform script, install Python on it and execute a "Hello World" Python program on it.

- Follow [steps to create Jenkins Server](https://github.com/Ajit1279/GCP_Learning/tree/main/250102_DevOpsProject/1_Jenkins_on_GCPVM).

- If you face any error installing Jenkins follow answer from Timothy Godonu on [Stackoverflow](https://stackoverflow.com/questions/70541720/jenkins-has-no-installation-candidate-error-while-trying-to-install-jenkins-on)

        sudo apt update
        sudo apt install openjdk-17-jre
        java -version

         curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
           /usr/share/keyrings/jenkins-keyring.asc > /dev/null
         echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
         https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
          /etc/apt/sources.list.d/jenkins.list > /dev/null

         sudo apt-get update
         sudo apt-get install jenkins
         sudo systemctl start jenkins.service
         sudo systemctl status jenkins

- Created a Jenkinsfile so that [Jenkins](https://github.com/Ajit1279/GCP_Learning/blob/main/250102_DevOpsProject/2_Jenkins_VM_Python/Jenkinsfile) job is triggered only if there are changes in this directory, (Reference [here](https://stackoverflow.com/questions/47600390/trigger-specific-jenkins-job-on-github-push-to-specific-directory)), but it didn't work. The Groovy script requires further analysis.

  ![image](https://github.com/user-attachments/assets/544a60ee-f0a7-4ea5-a9c1-e777e48e14fb)
   
- In the meantime created a [new repository](https://github.com/Ajit1279/jenkins-pythonvm) and ran the Jenkins job but it's failing with authentication error.

- Generate a github classic token and use it instead of password. This [DevOps4Solutions video](https://www.youtube.com/watch?v=Z9vLen1w8DU) was helpful

- Ensure to install git and terraform on the jenkins-server

          sudo apt update
          sudo apt upgrade -y
          sudo apt install git

   ![image](https://github.com/user-attachments/assets/a416ca61-911f-4149-91e7-c538205dcf9a)

          wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
          echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
          sudo apt update && sudo apt install terraform

    ![image](https://github.com/user-attachments/assets/21697364-e90f-4f9b-a4aa-5a253bc541b0)


- So let's configure user id and token correctly
  - Click on dashboard >> new item >> enter the git repository

     ![image](https://github.com/user-attachments/assets/446936cd-0f38-47a3-a741-889510b7fd08)

  - The error message appears because we haven't configured the credentials yet. Click in Add >> Select Jenkins

     ![image](https://github.com/user-attachments/assets/cfd760f7-4598-48f6-a0fe-5a0d99d8f455)

  - Configure the newly created token in the password field.

     ![image](https://github.com/user-attachments/assets/22c2fffc-6997-42f2-a459-3c9ecb3b9fde)

  -  
  -  
- sd
- sd
- sd
- s
- ds
- ds
- ds
- d
- sd
- sd
- sd
- sds
