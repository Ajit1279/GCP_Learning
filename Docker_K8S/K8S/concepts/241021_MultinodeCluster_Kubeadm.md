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
 - Create VMs and run commands to set-up control plane and worker nodes on those
   
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
