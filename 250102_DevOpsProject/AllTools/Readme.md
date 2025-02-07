- Reference: https://dev.to/prodevopsguytech/devops-project-production-level-cicd-pipeline-project-1iek

- Install Jenkins
  - Create VM instance on GCP

         gcloud compute instances create jenkins-server --project=devops2502 --zone=us-central1-f --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=488011902725-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=ijenkins-server,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250113,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

  
  - Ensure to configure firewall rules to allow SSH, HTTP and port 8080 enabled

          gcloud compute --project=devops2502 firewall-rules create http-8080 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8080 --source-ranges=0.0.0.0/0

    ![image](https://github.com/user-attachments/assets/52fbb45e-bbe4-4c2c-abb7-a61e39da24b0)

  - SSH into Jenkins-server and **[install Jenkins](https://github.com/Ajit1279/GCP_Learning/tree/main/250102_DevOpsProject/2_Jenkins_VM_Python)** on it

            sudo apt install openjdk-17-jdk
            sudo apt update
            sudo apt upgrade -y
            sudo apt install openjdk-17-jdk -y
            sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
            wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
            sudo apt update
            sudo apt install jenkins -y
            sudo systemctl start jenkins
            sudo systemctl status jenkins

  - It gave an error. Run commands below to resolve

    ![image](https://github.com/user-attachments/assets/112a92b6-c471-4086-bd21-07c7902d8d03)

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

  - Jenkins server is up now

    ![image](https://github.com/user-attachments/assets/77d8e1dc-3a11-4402-be8d-2e4fee94c5ae)

  - Enter the external IP address and port 8080 after it to access Jenkins thru Browser  35.202.103.175:8080. Enter initial password and proceed with the set-up

     ![image](https://github.com/user-attachments/assets/57194f64-136e-4473-b757-047fc4fc4dad)

  - SSH into jenkins-server and [intall git and terraform](https://github.com/Ajit1279/GCP_Learning/tree/main/250102_DevOpsProject/1_Jenkins_on_GCPVM)

            sudo apt update
            sudo apt upgrade -y
            sudo apt install git

            wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
            sudo apt update && sudo apt install terraform

  - Enter 'y' to continue with the set-up 

  - Install Docker
    - Update package list

           sudo apt-get update

    - Install Docker

            sudo apt-get install -y docker.io

    - Add Jenkins user to Docker group

             sudo usermod -aG docker jenkins

    - Restart Jenkins to apply group changes

                 sudo systemctl restart jenkins 

   
--------------------------------------------------------        
- Install Nexus
  - Create a GCP VM

           gcloud compute instances create nexus-server --project=devops2502 --zone=us-central1-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=488011902725-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=nexus-server,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250113,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

 - Ensure to open port 8081 through firewall

       gcloud compute --project=devops2502 firewall-rules create nexus --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8081 --source-ranges=0.0.0.0/0

 - Install Docker

          sudo apt-get update
          sudo apt-get install -y docker.io
         
 - Install Nexus

         docker run -d -p 8081:8081 --name nexus sonatype/nexus3
   
 - Access the Nexus server using the external IP address of the VM and port 8081 34.121.135.49:8081/

     ![image](https://github.com/user-attachments/assets/ca2ae6ad-9f3b-4c82-8df8-216fe3144ad4)

 - Use the default user id: admin and password in admin.password file 

----------------------------------------------------------
- Set-up and launch SonarQube

     ![image](https://github.com/user-attachments/assets/ef442132-705a-4ef8-aad5-9c17b06186c5)

        
  - Install Trivy

                sudo apt-get install wget apt-transport-https gnupg lsb-release -y
                wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
                echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
                sudo apt-get update
                sudo apt-get install trivy

  - 
  - 
- ds
- ds
- d
- sd
- sd
- sd
- sd
- sd
- s
