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
