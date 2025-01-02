- Reference: https://dev.to/prodevopsguytech/devops-project-production-level-cicd-pipeline-project-1iek

- Create VM instance on GCP

        gcloud compute instances create mylocalmachine --project=devops-446607 --zone=us-central1-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=807547610042-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=mylocalmachine,image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20241219,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

  
- Ensure to configure firewall rules to allow SSH, HTTP and port 8080 enabled

          gcloud compute --project=devops-446607 firewall-rules create http-8080 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8080 --source-ranges=0.0.0.0/0

  ![image](https://github.com/user-attachments/assets/52fbb45e-bbe4-4c2c-abb7-a61e39da24b0)

- SSH into local machine and **install Jenkins** on it

        sudo apt-get update
        sudo apt-get install -y openjdk-11-jdk

  - Add Jenkins repo key to your system
    
                wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

  - Add Jenkins to your system's sources

               sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

  - Update package list

               sudo apt-get update

  - Install Jenkins

               sudo apt-get install -y jenkins

  - Start Jenkins service

               sudo systemctl start jenkins

  - The above steps returned error

    ![image](https://github.com/user-attachments/assets/d39240d4-1ade-4fd9-86d3-8acfa0bdd337)

  -  Follow the steps provided by "Faisal Nurr" in the [Stackoverflow thread](https://stackoverflow.com/questions/72412100/error-with-jenkins-installation-on-ubuntu-20-04). Verify the Jenkins status

                sudo systemctl status jenkins

    ![image](https://github.com/user-attachments/assets/bb8b5c97-cf72-45e8-bdcf-ee12aff2e4e0)


- Install Nexus
  - Install Docker
    - Update package list

                 sudo apt-get update

    - Install Docker

                 sudo apt-get install -y docker.io

    - Add Jenkins user to Docker group

                 sudo usermod -aG docker jenkins

    - Restart Jenkins to apply group changes

                 sudo systemctl restart jenkins 
          
  - Set-up & launch Nexus on Docker: 

                 docker run -d -p 8081:8081 --name nexus sonatype/nexus3
 
      dc0968eecc4d081d9acaa989c6e357e60d6e0555ccf6a15174102db8111262ae

     ![image](https://github.com/user-attachments/assets/89dddfac-5c05-4b04-8588-d5caab8a0143)

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
