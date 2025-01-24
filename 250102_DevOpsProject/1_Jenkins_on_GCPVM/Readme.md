- Reference: https://www.youtube.com/watch?v=nhnDawbJrHE
- Reference: https://blog.kubekode.org/setup-and-install-jenkins-on-gcp-vm

- Steps:
  - Configure Default VPC Firewall Rules. Go to Console >> VPC >> Create new firewall rule jenkins-ci to allow all traffic

      ![image](https://github.com/user-attachments/assets/5b7a762f-7dea-48e0-9ffc-ce4c3999253b)

      ![image](https://github.com/user-attachments/assets/a9340ef9-3795-47d7-a5a0-b6cc69ace569)

  
  - Now create a compute vm named "jenkins-server"

          gcloud compute instances create jenkins-server --project=devops1279 --zone=us-central1-c --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=873091254667-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=jenkins,http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=jenkins-server,image=projects/debian-cloud/global/images/debian-12-bookworm-v20241210,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

      
  - Let's SSH into the VM and [install Jenkins](https://blog.kubekode.org/setup-and-install-jenkins-on-gcp-vm) on it

            sudo apt update
            sudo apt install openjdk-11-jre -y
            curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
               /usr/share/keyrings/jenkins-keyring.asc > /dev/null
            echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
               https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
               /etc/apt/sources.list.d/jenkins.list > /dev/null
            sudo apt-get update
            sudo apt-get install jenkins -y

  - It gave an error: Could not execute systemctl:  at /usr/bin/deb-systemd-invoke line 145.

      ![image](https://github.com/user-attachments/assets/cf59a0f2-471c-42b5-ac89-52acffd98c0a)

  -  Let's troubleshoot. Find out Debian version first

         lsb_release -a

       ![image](https://github.com/user-attachments/assets/7dbbeb85-2077-46f5-9a58-b675f4b039c3)

  - Referring to Gemini

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

  - Open a web browser and go to: http://34.135.175.0:8080 (external IP Address of the VM on which Jenkins is installed)

    ![image](https://github.com/user-attachments/assets/a2510618-0794-4388-be75-37e88524ad36)

  - Complete Initial Setup:
    - Find the administrator password from the below file and enter in the browser
 
           sudo cat /var/lib/jenkins/secrets/initialAdminPassword
 
      ![image](https://github.com/user-attachments/assets/797e9179-206d-4d7d-a970-f02b0a3a554f)
  
    - Choose to install suggested plugins or select specific plugins
 
      ![image](https://github.com/user-attachments/assets/9d5f6452-0616-4c18-96a7-ffbad822130f)


      ![image](https://github.com/user-attachments/assets/2a454e67-1bc1-46ea-851c-011975e47ec8)


    - Create an admin user.         

       ![image](https://github.com/user-attachments/assets/ed7df86f-e655-47db-8a60-7932c905bbb9)


       ![image](https://github.com/user-attachments/assets/0432d09d-49ce-45ba-9ae1-90034eecbcc8)


       ![image](https://github.com/user-attachments/assets/a9a8f68f-0166-4fe6-884a-045a3c55d7e6)


       ![image](https://github.com/user-attachments/assets/16bb619e-9764-443d-8fca-ce1ec41ac797)


  - Now let's follow the steps to [configure github repository](https://github.com/Ajit1279/GCP_Learning/tree/main/250102_DevOpsProject/Jenkins_Terraform) in the Jenkins, but it failed with the error "Failed to connect to Repository: Command git ls-remote -h ....." as shown below.     

      ![image](https://github.com/user-attachments/assets/ded5fa79-88c9-4cde-bc43-c7b205d8964a)

  - Refer [this video](https://youtu.be/F5QKON50xP8) to resolve the error, followed the steps suggested [here](https://www.linuxbuzz.com/how-to-install-git-on-debian/) to install git on the jenkins-server

      ![image](https://github.com/user-attachments/assets/9b24de50-b19c-4367-9b4f-edaf885ae4b3)

  - The job started successfully, but ran into different error now: "ERROR: Couldn't find any revision to build. Verify the repository and branch configuration for this job."

      ![image](https://github.com/user-attachments/assets/faac6af4-620e-40f0-9f58-d0161894176d)

  - The error was resolved referring to the answer by MarkEWaite on [Jenkins community](https://community.jenkins.io/t/error-couldnt-find-any-revision-to-build/14430)

      ![image](https://github.com/user-attachments/assets/b6993841-18d9-4f3b-b0b4-0b13f5148499)

  - However, because terraform is not installed on new VM, it resulted in the below error

      ![image](https://github.com/user-attachments/assets/784d6134-d6be-4430-a5ac-71ae39e3ec4e)
      
  - Installed it by [following the instructions](https://github.com/Ajit1279/GCP_Learning/tree/main/250102_DevOpsProject/Jenkins_Terraform)

     ![image](https://github.com/user-attachments/assets/e5690a90-9f4e-4332-afbf-e228a88978aa)


  - Now let's re run the pipeline and when prompted, click on "proceed"

      ![image](https://github.com/user-attachments/assets/6f5696f2-ccf9-46c8-aa98-b38b83c2b0f1)

      ![image](https://github.com/user-attachments/assets/d2005d68-3ec0-40bd-8740-2258af217dc3)


  - The build failed with error: 400

      ![image](https://github.com/user-attachments/assets/f0b2d18a-fe76-41e8-844f-db44cf2b083c)

  - Let's try changing the location from asia-south1-c to us-central1-a in main.tf. It failed with the same error.
    
  - Referring to the [bucket locations](https://cloud.google.com/storage/docs/locations), it should be ASIA-SOUTH1 or US-CENTRAL1. Let's updated main.tf and re-run the job

      ![image](https://github.com/user-attachments/assets/74545858-fc65-40bd-9bad-07ed829f4824)

    
  - Go to Console >> Buckets and verify the bucket is created

      ![image](https://github.com/user-attachments/assets/2309452c-7aad-4ca0-bf0a-04aa6bbf13de)

  
