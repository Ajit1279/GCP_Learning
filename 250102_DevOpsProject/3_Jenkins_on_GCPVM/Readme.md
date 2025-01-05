- Reference: https://www.youtube.com/watch?v=nhnDawbJrHE
- Reference: https://blog.kubekode.org/setup-and-install-jenkins-on-gcp-vm

- Steps:
  - Configure Default VPC Firewall Rules. Go to Console >> VPC >> Create new firewall rule jenkins-ci to allow all traffic

      ![image](https://github.com/user-attachments/assets/5b7a762f-7dea-48e0-9ffc-ce4c3999253b)

      ![image](https://github.com/user-attachments/assets/a9340ef9-3795-47d7-a5a0-b6cc69ace569)

  
  - Now create a compute vm named "jenkins-server"

          gcloud compute instances create jenkins-server --project=devops1279 --zone=us-central1-c --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --metadata=startup-script=\ \ sudo\ apt\ update$'\n'\ \ sudo\ apt\ install\ openjdk-11-jre\ -y$'\n'\ \ curl\ -fsSL\ https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key\ \|\ sudo\ tee\ \\$'\n'\ \ \ \ /usr/share/keyrings/jenkins-keyring.asc\ \>\ /dev/null$'\n'\ \ echo\ deb\ \[signed-by=/usr/share/keyrings/jenkins-keyring.asc\]\ \\$'\n'\ \ \ \ https://pkg.jenkins.io/debian-stable\ binary/\ \|\ sudo\ tee\ \\$'\n'\ \ \ \ /etc/apt/sources.list.d/jenkins.list\ \>\ /dev/null$'\n'\ \ sudo\ apt-get\ update$'\n'\ \ sudo\ apt-get\ install\ jenkins\ -y --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=873091254667-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append --tags=jenkins,http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=jenkins-server,image=projects/debian-cloud/global/images/debian-12-bookworm-v20241210,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

      
  - The VM is created successfully, let's try to access it using external IP.

      ![image](https://github.com/user-attachments/assets/8e8e767c-3493-46ec-83c1-12df5c664d26)


  - The VM was not accessible on port 8080 or 80

      ![image](https://github.com/user-attachments/assets/0a66a75d-a07c-447b-b744-f4b26e66b259)

  - ds
  - ds
  - d
  - sd
  - sd
  - sd
  - s
  - ds
  - ds
  - d
  - sd
  - sd  
