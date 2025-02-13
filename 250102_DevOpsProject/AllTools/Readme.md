- Reference: https://dev.to/prodevopsguytech/devops-project-production-level-cicd-pipeline-project-1iek
- Reference: https://github.com/hashicorp/terraform-provider-google

- Let's translate the AWS-based DevOps pipeline from the article above to a **GCP equivalent**.  I'll break down the key components and their GCP counterparts:

  - **Code Repository:** No change needed if you are already using GitHub. If you wish to use a GCP native solution, you would migrate to Cloud Source Repositories.

  - **Build Automation and Artifact Storage:** Instead of S3, you'll use Artifact Registry to store your built artifacts (container images, JAR files, etc.).  Cloud Build can directly push images to Artifact Registry.

  - **Container Orchestration:** Use GKE to deploy and manage your application containers.
  
  - **Infrastructure as Code (IaC):** Terraform is cross-cloud and can be used on both. If you are using CloudFormation on AWS, you would migrate to Terraform or Deployment Manager on GCP. Terraform is very common for IaC on GCP.

  - **Monitoring and Logging:** Cloud Monitoring and Cloud Logging are the services you'll use to collect metrics, logs, and traces from your applications and infrastructure.

  - **CI/CD Orchestration:**
    - **Jenkins:**
      - **Deployment**: You can deploy Jenkins on a Compute Engine VM or within a GKE cluster (GKE is generally preferred for scalability and management).
      - **Integration with GCP:** Use the Jenkins Google Cloud Plugin to integrate Jenkins with GCP services like Cloud Build, GKE, and Artifact Registry.
      - **Pipeline Definition:** Define your CI/CD pipeline in a Jenkinsfile to orchestrate the build, test, and deployment stages, integrating with the other tools.

    - **SonarQube:**
      - **Deployment:** Deploy SonarQube on a Compute Engine VM or within GKE, similar to Jenkins.
      - **Integration with Jenkins:** Use the SonarQube Scanner plugin in your Jenkins pipeline to analyze your code for quality and security vulnerabilities. The scanner will send the code to SonarQube for analysis.
      - **Quality Gates:** Configure quality gates in SonarQube to define criteria for successful builds (e.g., code coverage, vulnerability thresholds). Your Jenkins pipeline can check these quality gates and fail the build if they are not met.

    - **Nexus:**
      - **Deployment:** Deploy Nexus on a Compute Engine VM or within GKE. Nexus is a repository manager that can store your build artifacts (e.g., JAR files, container images).
      - **Integration with Jenkins:** Use the Nexus plugin in Jenkins to publish your build artifacts to Nexus. You can also configure Jenkins to download dependencies from Nexus.
      - **Container Registry (Alternative):** For container images specifically, consider using Artifact Registry as your container registry.

    - **Trivy:**
      - **Integration with Jenkins:** Use Trivy within Jenkins pipeline to scan your container images for vulnerabilities. Trivy can be run as a command-line tool. For initial testing installing Trivy on the same VM as Jenkins is perfectly acceptable.
      - **Vulnerability Scanning:** Trivy will analyze the layers of your container images and report any known vulnerabilities. You can configure your Jenkins pipeline to fail the build if critical vulnerabilities are found.  

----------------------------------------------------
- Install Jenkins
  - Create VM instance on GCP

   ```
    gcloud compute instances create jenkins-server --project=devops2502 --zone=us-central1-f --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=488011902725-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=ijenkins-server,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250113,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any
   ```

  
  - Ensure to configure firewall rules to allow SSH, HTTP and port 8080 enabled

   ```
   gcloud compute --project=devops2502 firewall-rules create http-8080 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8080 --source-ranges=0.0.0.0/0
   ```
    

    ![image](https://github.com/user-attachments/assets/52fbb45e-bbe4-4c2c-abb7-a61e39da24b0)

  - SSH into Jenkins-server and **[install Jenkins](https://github.com/Ajit1279/GCP_Learning/tree/main/250102_DevOpsProject/2_Jenkins_VM_Python)** on it

    ```
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
    ```

  - It gave an error. Run commands below to resolve

    ![image](https://github.com/user-attachments/assets/112a92b6-c471-4086-bd21-07c7902d8d03)


    ```
    sudo apt update
    sudo apt install openjdk-17-jre
    java -version
    ```

    ```
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
         /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    ```

    ```
    sudo apt-get update
    sudo apt-get install jenkins
    sudo systemctl start jenkins.service
    sudo systemctl status jenkins
    ```
    

  - Jenkins server is up now

    ![image](https://github.com/user-attachments/assets/77d8e1dc-3a11-4402-be8d-2e4fee94c5ae)

  - Enter the external IP address and port 8080 after it to access Jenkins thru Browser  35.202.103.175:8080. Enter initial password and proceed with the set-up

     ![image](https://github.com/user-attachments/assets/57194f64-136e-4473-b757-047fc4fc4dad)

  - SSH into jenkins-server and [intall git and terraform](https://github.com/Ajit1279/GCP_Learning/tree/main/250102_DevOpsProject/1_Jenkins_on_GCPVM)

    ```
    sudo apt update
    sudo apt upgrade -y
    sudo apt install git
    ```

    ```
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform
    ```

  - Enter 'y' to continue with the set-up 

  - Install Docker
    - Update package list

      ```
      sudo apt-get update
      ```

    - Install Docker

       ```
       sudo apt-get install -y docker.io
       ``` 

    - Add Jenkins user to Docker group
      
       ```
       sudo usermod -aG docker jenkins
       ```
       
    - Restart Jenkins to apply group changes

       ```
       sudo systemctl restart jenkins 
       ```
       
  - To **create Jenkins Service Account** go to Console >> iAM >> Service Accounts >> Create Service Account (jenkins-sa@devops2502.iam.gserviceaccount.co) and assign "Kubernetes Engine Cluster Admin" and "Artifact Registry Admin" roles

    ![image](https://github.com/user-attachments/assets/b06682dd-7604-4b8d-b23d-83423c6b96f2)

    

  -  
  - 
  - 
  - 
--------------------------------------------------------        
- Install Nexus
  - Create a GCP VM

    ```
    gcloud compute instances create nexus-server --project=devops2502 --zone=us-central1-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=488011902725-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=nexus-server,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250113,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any
    ```

 - Ensure to open port 8081 through firewall

   ```
   gcloud compute --project=devops2502 firewall-rules create nexus --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8081 --source-ranges=0.0.0.0/0
   ```

 - Install Docker

   ```
   sudo apt-get update
   sudo apt-get install -y docker.io
   ```
         
 - Install Nexus

   ```
   docker run -d -p 8081:8081 --name nexus sonatype/nexus3
   ```
   
 - Access the Nexus server using the external IP address of the VM and port 8081 34.121.135.49:8081/

     ![image](https://github.com/user-attachments/assets/ca2ae6ad-9f3b-4c82-8df8-216fe3144ad4)

 - To get the default user id: admin and password in admin.password file type
   - Get the container Id of the Nexus container
      
      ```
      sudo docker ps
      ```

       ![image](https://github.com/user-attachments/assets/8797f50a-068c-488d-ac0e-10fae243c3ca)


   - Run the below command to read the admin password file

     ```
     sudo docker exec -it 080f841f3c19 cat /nexus-data/admin.password
     ```

      ![image](https://github.com/user-attachments/assets/9c708847-4f12-47fa-b661-e4842043acb6)

   - Enter the encrypted password in the password field. The login was successful!!

       ![image](https://github.com/user-attachments/assets/1405c81f-21ca-4000-9d76-87b9f329de8b)

   - Change the default password, enable / disable Anonymous access, it's ready to use now

       ![image](https://github.com/user-attachments/assets/5008eb3c-f696-4b90-9cc3-a8be24dbd18d)
     
 

----------------------------------------------------------
- Set-up and launch SonarQube
  - Create GCP VM

    ```
    gcloud compute instances create sonarqube-server --project=devops2502 --zone=us-central1-f --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=488011902725-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=sonarqube-server,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250113,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any
    ```

  - SSH into server and install docker

    ```
    sudo apt-get update
    sudo apt-get install -y docker.io
    ```

  - Ensure to configure firewall rules to allow SSH, HTTP and port 9000 enabled. Run the below command in **Cloudshell**

   ```
   gcloud compute --project=devops2502 firewall-rules create http-9000 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9000 --source-ranges=0.0.0.0/0
   ```  

  - Launch SonarQube on Docker

    ```
    sudo docker run -d -p 9000:9000 --name sonarqube sonarqube
    ```

    ![image](https://github.com/user-attachments/assets/a97cb2de-9d05-497d-a155-56a175c20611)


  - Access Sonarqube using the external IP address and default password admin/admin

      ![image](https://github.com/user-attachments/assets/c0ed2658-ab52-49b6-a5b9-111bdcce99de)


  - Go through the [documentation](https://docs.sonarsource.com/sonarqube-community-build/) if needed

  -----------------------------------------------------------------------

  - Install Trivy
   - Create GCP VM
     ```
     gcloud compute instances create trivy-server --project=devops2502 --zone=us-central1-f --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=488011902725-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=trivy-server,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250113,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any
     ``` 
   
   - Run commands to install Trivy
     ```
     sudo apt-get install wget apt-transport-https gnupg lsb-release -y
     wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
     echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
     sudo apt-get update
     sudo apt-get install trivy
    ```
---------------------------------------------------------------
- Terraform
  - Create [main.tf](https://github.com/Ajit1279/GCP_Learning/blob/main/250102_DevOpsProject/AllTools/main.tf)

  - Create [deployment.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/250102_DevOpsProject/AllTools/deployment.yaml)

  - To set-up Jenkins pipeline, go to Jenkins Dashboard >> New Item >> Pipeline >> select "Pipeline script from SCM" and input the [Jenkinsfile](https://github.com/Ajit1279/GCP_Learning/blob/main/250102_DevOpsProject/AllTools/Jenkinsfile) in Script Path 
    

-------------------------------------------------------------------------
