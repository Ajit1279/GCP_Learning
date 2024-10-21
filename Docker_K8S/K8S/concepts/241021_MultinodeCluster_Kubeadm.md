- Reference: https://www.youtube.com/watch?v=WcdMC3Lj4tU&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=28

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
