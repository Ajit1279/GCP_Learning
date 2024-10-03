- Reference: https://www.youtube.com/watch?v=6eGf7_VSbrQ&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=14

- **Static Pods:**
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

    - Now let's move the kube-scheduler.yaml from this directory to temp directory **mv kube-scheduler.yaml /tmp**
 
      ![image](https://github.com/user-attachments/assets/ddb82b14-d6ef-45e1-b337-117bc6f7a283)

    - Now come out of the container and run command to see if kube-scheduler is running: **sudo kubectl get pods -n kube-system | grep scheduler**. It returns nothing
 
      ![image](https://github.com/user-attachments/assets/7925b68e-e268-471c-b2ad-41d8e3a129fa)

    - Type **sudo kubectl get pods -n kube-system** and it'll show all other control plane components are running. 
 
      ![image](https://github.com/user-attachments/assets/0ea89d39-aab4-4ae8-9159-1c2690524a54)

    - As observed above, the **control plane doesn't go down**, but if you try to schedule a new pod, it won't work. Type **sudo kubectl run nginx --image=nginx**. It'll show that the pod is created, but if you run the command **sudo kubectl get pods** it's in **"Pending"** status
 
      ![image](https://github.com/user-attachments/assets/4212213b-a3cd-4169-aa35-1b61f23ccd98)

    - Now let's move the kube-scheduler.yaml from tmp directory to the etc/kubernetes/manifests directory:
      - sudo docker exec -it 041ad5bd43d5 sh
      - cd tmp
      - ls -lrt
      - mv kube-scheduler.yaml /etc/kubernetes/manifests
      - cd /etc/kubernetes/manifests
      - ls -lrt

      ![image](https://github.com/user-attachments/assets/371261aa-5a89-4656-bbe2-aa88f028063d)

    - Come out of container and run: **sudo kubectl get pods**. Now the nginx pod is running
 
      ![image](https://github.com/user-attachments/assets/81a85683-0555-476c-a85d-a4ca3e01ad43)

    - Run: **sudo kubectl get pods -n kube-system | grep scheduler**, the scheduler is running as well
 
      ![image](https://github.com/user-attachments/assets/61ab940c-992a-4f14-8e46-104424a2548b)

-------------------------------------------------------

- **Manual Scheduling**
  - Please note that **scheduler "schedules" pods** to the nodes **only if no "selector" is provided** e.g. nodeName: worker1

  - Let's demo manual scheduling. Delete the nginx pod that we just created: **sudo kubectl delete pod nginx**

  - [Create a cluster](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md) with multiple worker nodes

    ![image](https://github.com/user-attachments/assets/7d4ca972-db54-49bf-aedc-9d2b8b4c48d3)

  - Run command: **sudo kubectl get nodes**

    ![image](https://github.com/user-attachments/assets/2e470b19-302f-4c03-bf41-1627689d1914)

  - Run the command: **sudo kubectl run nginx --image=nginx -o yaml > selectordemopod.yaml**. _**Please note the selectordemopod.yaml was corrected to manualscheduledemopod.yaml in github**_
    The [manualscheduledemopod.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/manualscheduledemopod.yaml) has many details, so let's trim it and create [manualscheduledemopod1.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/manualscheduledemopod1.yaml). 

  - Let's bring the scheduler down again as we did above:
    - **sudo docker ps**
 
      ![image](https://github.com/user-attachments/assets/b6b26ee5-2677-4ab5-b4dd-721a51c58f1d)

    - **sudo docker exec -it d6abc131d15d sh**

    - **cd /etc/kubernetes/manifests**
 
      ![image](https://github.com/user-attachments/assets/08234388-6cb4-4cc2-8993-f1bd173ca31b)

    - **mv kube-scheduler.yaml /tmp**
 
      ![image](https://github.com/user-attachments/assets/cd4034d3-9253-4137-ac8b-6a62fae40606)

    - **sudo kubectl get pods -n kube-system | grep scheduler**
 
      ![image](https://github.com/user-attachments/assets/721109cc-1b58-4287-a98d-3d5d09b04b49)

  - Now type: **sudo kubectl apply -f selectordemopod1.yaml**. Ideally the pod should not spin-off and attached to a node without scheduler, but see what happens:

    ![image](https://github.com/user-attachments/assets/3ec6ff11-33d7-41cc-a90b-d9ff52c1253c)

  - As seen above the pod is in running status (not pending). Let's run **sudo kubectl get pods -o wide**

    ![image](https://github.com/user-attachments/assets/c284fc57-e5c0-4163-b60b-b05d031b8b6d)

  - Please note that the pod is scheduled on kind-worker3 as we specified in our yaml

  - Please ensure to bring the kube-scheduler.yaml back to /etc/kubernetes/manifests: **mv /tmp/kube-scheduler.yaml .**  

------------------------------------------------------- 

- Please note **Selectors** and labels has been covered already in [Deployments_ReplicationController_ReplicaSets](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/240908_Deployments_ReplicaSets_ReplicationController.md) . So the information in this tutorial is appended in the above file
