- Reference: https://www.youtube.com/watch?v=WcdMC3Lj4tU&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=28
- Reference: https://kubernetes.io/docs/reference/networking/

- Basics
 - We need to identify the purpose to set-up a K8S cluster. The diagram below shows few examples, but this is not an exhaustive list

   ![image](https://github.com/user-attachments/assets/2510713f-ac07-4c08-b118-333626c05029)

 - For **PoCs or local set-up** only **Kind, K3s and Minikube** are recommended because:
   - It has limitations
   - Therotically it only splits your host (PC or VM) into multiple nodes, so does not have High Availability (HA)
 - For **self-managed** clusters:
   - You or your organization is responsible for maintaining all control-plane components, their security patching, upgrades etc.
   - **Vagrant, Virtualbox** are **suitable** for production **only if it's hosted in Data Centers**, **NOT** on **single host or MacOs**  
   - **Multipass:** are **suitable for MacOs**
   - **VMs on Cloud**
   - **baremetal or vmware**
 - For **Managed K8S on Cloud**
   - Use **EKS (Elastic Kubernetes Service)** or **AKS (Amazon Kubernetes Service)** or **GKE (Google Kubernetes Engine)**

-----------------------------------------
- Demo

  ![image](https://github.com/user-attachments/assets/a6a89dfb-10b0-49d7-b31d-bbee48a58bdb)

  
  ![image](https://github.com/user-attachments/assets/c2e56142-b49c-4373-8cda-1f8831df7a52)


- Steps:
 - Create Firewall Rules one each for control plane and worker nodes
   - Go to default VPC for your project (in this case us-central1) and find out the IP range (10.128.0.0/20)

      ![image](https://github.com/user-attachments/assets/32bb7692-10d5-4768-a317-e4666c227ed3)

   - Also create a small VM and note down it's IP to allow SSH into K8S. This is required while creating firewall rule to allow SSH on port 22. Only admin should have access to SSH

          gcloud compute instances create myvm --project=test66666666 --zone=us-central1-c --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=955233175770-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=myvm,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240617,mode=rw,size=10,type=projects/aiml21/zones/us-central1-c/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any
 
   - Custom TCP firewall rule to enable ports 10248 - 10260. Run the below command in Cloud Shell

          gcloud compute --project=test66666666 firewall-rules create cpfw1 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:10248-10260 --source-ranges=10.128.0.0/20

       ![image](https://github.com/user-attachments/assets/1a1701ce-0080-4c95-ac6d-306ea02c98e5)

   - Custom TCP firewall rule to enable ports 2379 - 2380

          gcloud compute --project=test66666666 firewall-rules create cpfw2 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:2379-2380 --source-ranges=10.128.0.0/20
     
   - Custom TCP firewall rule to enable port 6443

         gcloud compute --project=test66666666 firewall-rules create cpfw3 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:6443 --source-ranges=10.128.0.0/20
        
   - Custom SSH rule to enable port 22


      ![image](https://github.com/user-attachments/assets/29f6fc53-57db-40b4-9aa0-23da9193a7e0)

        
     
 - Create VMs and run commands to set-up control plane and worker nodes on those
  
   - Create Master Node

          gcloud compute instances create master-node --project=test66666666 --zone=us-central1-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=1006430257477-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=control-plane,http-server,https-server,lb-health-check --create-disk=auto-delete=yes,boot=yes,device-name=master-node,image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20241115,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

   -  Create two worker nodes
  
         gcloud compute instances create worker01 --project=test66666666 --zone=us-central1-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=1006430257477-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=worker,http-server,https-server,lb-health-check --create-disk=auto-delete=yes,boot=yes,device-name=worker01,image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20241115,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any


         gcloud compute instances create worker02 --project=test66666666 --zone=us-central1-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=1006430257477-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=worker,http-server,https-server,lb-health-check --create-disk=auto-delete=yes,boot=yes,device-name=worker02,image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20241115,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

      
   ![image](https://github.com/user-attachments/assets/358ff1ae-86ef-4bc0-a5a6-daf819c8d3ee)


 - Now let's set-up control-plane node i.e. master node

    - SSH into master node
    
    - [Run the commands](https://github.com/piyushsachdeva/CKA-2024/tree/main/Resources/Day27#run-the-below-steps-on-the-master-vm) to set-up the master-VM. Ensure all the values below are 1.

       ![image](https://github.com/user-attachments/assets/28ab702d-71e6-4926-8fa9-5b32a3757183)


    - Followed all the commands as is, but encountering the error

       ![image](https://github.com/user-attachments/assets/2ad3af75-e2e0-4736-ad34-415f95a14841)
 
   
   
--------------------------------------------- 
- **Step-by-step guide to upgrade Multi Node Kubernetes Cluster With Kubeadm**
  
- Reference: https://www.youtube.com/watch?v=NtX75Ze47EU&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=35
- Reference: https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

- Please refer the diagram below:
 - There's a master and three worker nodes.
 - There's Nginx deployment on all three worker nodes (Nginx-deploy)
 - There's also MySQL is single indendependent pod implemented without ReplicaSet, Deployment etc. in Worker1

    ![image](https://github.com/user-attachments/assets/b15bd50d-3318-4582-b985-55ec79c8b123)


- Now let's say if we want to bring down the Worker1 for maintenance then:
 - We've to "drain" (evicting) the node and mark worker1 as "unschedulable" (cordon)
 - Because we used the deployment for Nginx, it'll spin-up new pods in one of the available pods but the MySQL pod is gone forever as it's not part of any deployments. So all the data, configurations for this pod **can not be recovered**.

    ![image](https://github.com/user-attachments/assets/2cdfb10d-fed0-4ae0-bfbe-126ee36d3fa8)

 - If we schedule a new Redis pod, it'll be scheduled on Worker2 or Worker3

    ![image](https://github.com/user-attachments/assets/a21657a6-da5b-43d1-a96f-4217f84799c0)

 - We'll need to uncorden the node for it to get it working again.  
  - However this will not schedule existing Nginx pods again on Worker1, but a **new MySQL pod** will be **scheduled on Worker1** Node

- Upgrade:
 - Versions are denoted in three parts: Major, Minor and Patch so e.g. in 1.30.2 1 is major, 30 is minor and 2 is patch
 - Let's say there are 3 versions 1.28.1, 1.29.2 and 1.30.2
 - We can not upgrade to 1.30.2 from 1.28.1 directly, it has to be **one minor version upgrade at a time**
 - At any point K8S supports **only 3 minor versions** i.e. 28, 29 and 30. version 27 or prior won't be supported.
 - When the version is out of support, you can continue using it but there won't be product support for patches, upgrades etc.
 - If there's only one Master Node, it's not a High Availability (HA) Configuration, so if Master node is not functional, it does not impact already running workloads, but any tasks which require Master Node can not be performed e.g. new workloads can not be scheduled
 - There are various upgrade strategies:
  - All at once

    ![image](https://github.com/user-attachments/assets/2f6c73ab-9d94-4a73-9813-4f525fdc5a43)

  - Rolling Upgrade

    ![image](https://github.com/user-attachments/assets/4717996b-4b92-4934-a7c6-9e23e46576db)

  - Blue Green

    ![image](https://github.com/user-attachments/assets/8c516e9b-5d97-43cc-a1cd-479ab0ca4d13)

 
----------------------------------
 - **Upgrade Demo**
