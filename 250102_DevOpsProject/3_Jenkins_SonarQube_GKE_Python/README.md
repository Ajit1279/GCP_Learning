- **Pre-requisites**
  - **Code Repository:** No change needed if you are already using GitHub. If you wish to use a GCP native solution, you would migrate to Cloud Source Repositories.

  - **Build Automation and Artifact Storage:** Instead of S3, you'll use Google Artifact Registry to store your built artifacts (container images, JAR files, etc.).  Cloud Build can directly push images to Artifact Registry.

  - **Container Orchestration:** Use GKE to deploy and manage your application containers.
  
  - **Infrastructure as Code (IaC):** Terraform is cross-cloud and can be used on both. If you are using CloudFormation on AWS, you would migrate to Terraform or Deployment Manager on GCP. Terraform is very common for IaC on GCP.

  - **Monitoring and Logging:** Cloud Monitoring and Cloud Logging are the services you'll use to collect metrics, logs, and traces from your applications and infrastructure.

  - **CI/CD Orchestration:**
     - **Jenkins:**
        - **Deployment**: You can deploy Jenkins on a Compute Engine VM or within a GKE cluster (GKE is generally preferred for scalability and management).
        - **Integration with GCP:** Use the Jenkins Google Cloud Plugin to integrate Jenkins with GCP services like Cloud Build, GKE, and Artifact Registry.
        - **Pipeline Definition:** Define your CI/CD pipeline in a Jenkinsfile to orchestrate the build, test, and deployment stages, integrating with the other tools.

      - **Trivy:**
        - **Integration with Jenkins:** Use Trivy within Jenkins pipeline to scan your container images for vulnerabilities. Trivy can be run as a command-line tool. For initial testing installing Trivy on the same VM as Jenkins is perfectly acceptable.
        - **Vulnerability Scanning:** Trivy will analyze the layers of your container images and report any known vulnerabilities. You can configure your Jenkins pipeline to fail the build if critical vulnerabilities are found.  

      **OR** 

      - **SonarQube:**
        - **Deployment:** Deploy SonarQube on a Compute Engine VM or within GKE, similar to Jenkins.
        - **Integration with Jenkins:** Use the SonarQube Scanner plugin in your Jenkins pipeline to analyze your code for quality and security vulnerabilities. The scanner will send the code to SonarQube for analysis.
        - **Quality Gates:** Configure quality gates in SonarQube to define criteria for successful builds (e.g., code coverage, vulnerability thresholds). Your Jenkins pipeline can check these quality gates and fail the build if they are not met.

      - **Google Artifact Registry:** For container images specifically, consider using Artifact Registry as your container registry.

      - **Nexus (Alternative to Google Artifact Registry):**
        - **Deployment:** Deploy Nexus on a Compute Engine VM or within GKE. Nexus is a repository manager that can store your build artifacts (e.g., JAR files, container images).
        - **Integration with Jenkins:** Use the Nexus plugin in Jenkins to publish your build artifacts to Nexus. You can also configure Jenkins to download dependencies from Nexus.
  
----------------------------------------------------
Please ensure to follow the github structure as shown below, as otherwise the deployment pipeline may not work


app
\
|___Dockerfile
\
|___app.py
\
|___requirements.txt
\
|.dockerignore
\
|
\
|Jenkinsfile
\
|
\
|deployment.yaml
\
|
\
|main.tf
\
|
\
|sonar-project-properties

-------------------------
Here's the plan:

- **Infrastructure Setup**
  - Run Terraform to provision Jenkins and SonarQube on GCP.
  - Verify that Jenkins and SonarQube are up and running.

- **CI/CD Pipeline**
  - Pulls application code from Git.
  - Builds and pushes a Docker image to Google Artifact Registry.
  - Runs SonarQube analysis.
  - Deploys the application on GKE.

-------------------------------------
- Please follow the steps below to set-up various environments and tools
  
- **GCP project set-up**
  - A new GCP project devops-on-gcp is created for this example. One can use existing project.

  - Enable APIOs: **Compute Engine API, Kubernetes Engine API**

  - **Create Google Cloud Service Account**
    - Go to iAM & Admin >> Service Account >> Create service account (say jenkins-sa)
    - Grant access to project by assigning following roles: Artifact Registry Administrator, Artifact Registry Reader, Artifact Registry Writer, Kubernetes Engine Cluster Admin, Kubernetes Engine Service Agent, Storage Object Admin
    - Click on Done
   
  - **Create credentials file for Service Account**. This file will need to be integrated within Jenkins job to access Google Cloud Environment
    - Click on three dots in the "actions" field on the right hand side of service account
    - Click on "Manage Keys" >> Add Key >> Create new key >> JSON >>
    - A JSON file will be created and downloaded to your local machine. Please keep it secure
    - This file need to be uploaded to Jenkins as GOOGLE_APPLICATION_CREDENTIALS.
   
  - **Create Repository in Artifact Registry**
    - Go to Artifact Registry >> Create Repository
      - Name: my-docker-repo
      - Format: Docker
      - Mode: Standard
      - Region: us-central1
      - Keep the rest of the values as default and click on "Create"

      ![image](https://github.com/user-attachments/assets/0810a01d-7b9a-484d-9283-f4c3d1ccd010)


-----------------------------
- **Infrastructure Set-up**
  - Create [main.tf](https://github.com/Ajit1279/GCPStaging/blob/main/main.tf)
    
  - Run terraform init, terraform plan and terraform apply commands manually to check if the servers are created and Jenkins and Sonarqube is installed on it

  - Usually the servers are created but software installation doesn't work, run those steps manually. 
---------------------------------------------- 
- **Jenkins set-up**
  - Obtain initial password from /var/lib/jenkins/secrets/initialAdminPassword on Jenkins server

  - **Install recommended plugins**.

  - Please also ensure to install below plugins. Start with the core plugins and add others as needed to keep your Jenkins instance lean.

    - Go to Dashboard >> Manage Jenkins >> Plugins.  
      - SonarQube Scanner
      - Google OAuth Credentials
      - Google Login
      - Google Container Registry Auth
      - Google Kubernetes Engine
      - Google APIs Client Library
      - GCloud SDK
      - GCP Secrets Manager Credentials Provider
      - Pipeline: REST API
      - Pipeline: Stage View
      - Docker
      - Docker Pipeline
      - Pipeline Maven Integration
      - Pipeline Maven Plugin API
      - Pipeline: Github
      - Pipeline: Shared Groovy Libraries through HTTP retrievalVersion
      - GitHub Authentication
      - Git Push
      - Kubernetes
      - Kubernetes CLI
      - Kubernetes Credentials
      - Kubernetes Credentials Provider
      - Kubernetes :: Pipeline :: DevOps StepsVersion
      
  - Restart Jenkins when installation is complete. The downloaded plugins can be verified at Dashboard > Manage Jenkins > Plugins > Installed plugins 

  - **Manually Install git on Jenkins server**

          sudo apt update
          sudo apt install git -y

    - Verify git path (It should return a valid path like /usr/bin/git. If not, you may need to add Git to the PATH.)
 
          which git

    - Restart Jenkins after installing git
   
          sudo systemctl restart jenkins
 
  - **Manually Install terraform**
    - Check the OS version of the Jenkins server 

             lsb_release -a

    - Run the commands below directly on the server

            wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
            sudo apt update && sudo apt install terraform
 
    - Check the terraform version
 
            terraform --version

  - **Manually install Docker**

           sudo apt update
           sudo apt install -y docker.io

     - Verify the version

           docker --version

     - Ensure Jenkins has Docker permissions
     
           sudo usermod -aG docker jenkins

     - Restart the Jenkins

            sudo systemctl restart jenkins


  - **Systems set-up**. In this UI we add all the systems to be integrated. Go to dashboard > Manage Jenkins > System
    - **Jenkins** url is auto populated

    - **SonarQube Servers**:
      - "Check" the Environment variables checkbox

      - Click on "Add SonarQube" (Please ensure that project with "sonarqubescan" is created prior to this step)
        - Name: sonarqubescan
        - Server url: Internal IP address of the SonarQube server
        - Server Authentication Token:
          - **Login to Sonarqube server**. To keep it simple (but not recommended) we'll use our admin id at the top right hand corner (best practice is to use service account)
          - Click on "security" >> Generate Token
          - Name: sonarqube-token (ensure to match it in Jenkins system set-up and Jenkinsfile)
          - Type: Project Analysis Token, Project: sonarqubescan. Click on Generate
          - Ensure to note the token in the safe place, as this need to be conifured in Jenkins 
        - Now back in Jenkins server, click on "Add" > Jenkins: Global Unrestricted, secret text, the name should match in Jenkinsfile
     
          ![image](https://github.com/user-attachments/assets/bbc4c971-9bd1-42cb-a0cf-d16d9fff4d69)

        - Ignore rest of the systems for now. Click on Save   

  - **Tools set-up**
    - Scroll down to "SonarQube Scanner installations" >> Add SonarQube Scanner
      - Name: sonarqubescan (should match in Jenkinsfile)
      - Check "Install Automatically) >> Install from Maven Central >> Select latest Version      
      - Click on Save

  - **Credentials**
    - Go to Jenkins >> Dashboard >> Manage Jenkins >> Credentials >> Global >> Add Credentials

    - Enter the information as shown below. Please ensure to keep the "ID" mentioned here and Jenkinsfile matches, otherwise the piepline will fail.

        ![image](https://github.com/user-attachments/assets/754b8e92-ecca-44a8-b06c-5e13733c7362)

    - Click on "Create".    
     
  - **New pipeline set-up**
    - Dashboard >> New Item
    - item name: python-hello-world
    - item type: pipeline
    - Click on "OK"
    - Scroll down to Pipeline section
    - In definition, select "Pipeline Script from SCM" from dropdown
    - SCM: git
    - Repositories >> Repository url >> HTTPS url of the git repo (https://github.com/Ajit1279/GCPStaging.git)
    - Credentials: Add >> Click on Jenkins
      - Domain: Global Credentials (unrestricted)
      - Kind: User name with Password
      - Scope: Global
      - Username: Your github user name (e.g. Ajit1279) in this case
      - Password: the secret token for your github account (your github id >> Settings >> developer settings >> generate new token)
      - ID: git-token (should match in Jenkinsfile)
      - Description: say "git access token for the GCP staging Repo"
      - Click on "add"
      - Branches to build >> branch specifier: "*/main"
      - Scriptpath: Jenkinsfile
      - Check the "Lightweight checkout" box
      - Click on "Save"    
-----------------------------------------
- **SonarQube set-up**
  - Click on "Create a local project". Project display name: sonarqubescan, Project key: populated automatically as same as Project Display name. Main branch name: Keep as main.
  - Use the global setting
  - Click on Create project
  - Analysis Method
    - How do you want to analyze your repository: Select "With Jenkins"
    - Select DevOps platform: GitHub

  - It will display a code to create "[sonar-project.properties](https://github.com/Ajit1279/GCPStaging/blob/main/sonar-project.properties)" file, which need to be kept in the repository  

  - Please note, at times, the sonarqube may shut down temporarily due to inactivity. Follow these steps to start it again:
    - To start existing container

            sudo docker start sonarqube
    
    - Stop and Remove the Existing Container. Please note, this will require entire set-up to be repeated
      - First, you need to stop and remove the existing container before you can start a new one with the same name.
  
              sudo docker stop sonarqube
              sudo docker rm sonarqube     

      - After removing the old container, you can start a new one with the same name:

              sudo docker run -d -p 9000:9000 --name sonarqube sonarqube  
--------------------------------
- Check-in / create all the files in the github repository as per the tree structure shown above

- Now let's start running pipeline and troubleshoot issues along the way.

- Click on Dashboard >> Jenkins Job name >> Buils Now. Check the status / logs in "Console Output"

- **Once the pipeline runs successfully and returns error only at "Deploy to GKE" stage, create a cluster**. This avoid unnecessary charges for GKE cluster (Alternatively if you are not tracking the cost, you can add gke cluster creation in main.tf itself, but may incur significant charges until you reach this stage, as there may be quite a fixes required to reach this stage)
  - Go to Kuberenets Engine >> Clusters >> Create
    - Name: my-gke-cluster
    - region: us-central1
    - Cluster tier: standard and Click on Next
    - skip Fleet Registration
    - In Networking >> check the box "Access using DNS", "Access using IPV4 address", 
    - Proceed with "Advanced settings". Skip Automation, Service Mesh, Backup plan
    - In Security Access Scopes select "Allow full access to all Cloud APIs" to avoid unnecessary errors due to lack of access, as this is just a test environment
    - Review and Create. It may take a while to create the GKE cluster.    

- Now let's rerun the Jenkins pipeline

------------------------------------------
- As shown below the pipeline ran successfully!

    ![image](https://github.com/user-attachments/assets/80ef10eb-19c2-4e42-b356-c18e235c61ef)

- Login to the Google Cloud Shell and enter

        gcloud container clusters get-credentials my-gke-cluster --region us-central1 --project devopsongcp

- Then enter below command to check if the GKE service has been created successfully

          kubectl get svc
  

  ![image](https://github.com/user-attachments/assets/b15e1c8c-caf7-4698-af6d-d67e717f758b)

- Copy the external IP address of the service and enter in the browser: <external-ip>:80. It displays the message below. Hurraahhh!!!!

  ![image](https://github.com/user-attachments/assets/efd27334-1b8c-4917-8123-ddbc9703483c)

- Also login to SonarQube url. It shows

  ![image](https://github.com/user-attachments/assets/8223f9e1-688a-4ebf-91c8-5fd0dbd2c9b9)

- So our Jenkins CI/CD pipeline is working end-to-end!!
---------------------------------------------------------
- Clean-up:
    - Delete the GKE cluster manually, as it was not created using terraform
    
    - run to delete Jenkins-server and SonarQube server. 

          terraform destroy

