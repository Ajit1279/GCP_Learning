- Reference: https://www.youtube.com/watch?v=6eGf7_VSbrQ&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=14

- Static Pods:
  - Before explaining this term, please recall that scheduler attaches a new pod to the available nodes via a kubelet in node. 

  - But, scheduler itself is kind of a pod. So ever wondered how this pod is scheduled to a node?

  - **Static pods are control plane components which are not managed by scheduler**

  - **Kubelet schedule the Scheduler to a control plane**   

  - **Demo**
    - Follow [instructions](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md) to create a VM and install docker, Kind Cluster and Kubectl on it

    - Enter the command: **sudo kubectl get pods -n kube-system -o wide | grep scheduler**
 
      ![image](https://github.com/user-attachments/assets/49accdac-ae9f-4c32-abfa-92955beffb15)

    - Run the command to check all the running containers: **sudo docker ps**
 
      ![image](https://github.com/user-attachments/assets/e669add7-b282-4315-a164-ec26b5fe0227)

    - To enter into container, type command: **sudo docker exec -it 0251955f1588 sh**
 
      ![image](https://github.com/user-attachments/assets/98e7d788-4a0f-460f-9d08-a0310b569a90)

    - Now type: **ps -ef | grep kubelete**
 
      ![image](https://github.com/user-attachments/assets/7e955b93-9c4b-46de-a85d-9953183b15a3)
      
    - Type command: **cd etc/kubernetes/manifests** followed by **ls -lrt**. This is the **default directory in which the manifests of static pods are stored**
 
      ![image](https://github.com/user-attachments/assets/bb205a2d-f678-4e02-8477-a5daf4e3b767)

    -  
