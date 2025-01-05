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

  - Open a web browser and go to: http://<your-vm-external-ip>:8080

  - Complete Initial Setup: 1. Enter the administrator password. 2. Choose to install suggested plugins or select specific plugins. 3. Create an admin user.         
