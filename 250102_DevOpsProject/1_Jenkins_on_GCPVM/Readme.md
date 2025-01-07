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
          sudo cat /var/lib/jenkins/secrets/initialAdminPassword

  - Open a web browser and go to: http://34.135.175.0:8080

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
