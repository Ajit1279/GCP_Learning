- Reference: https://www.youtube.com/watch?v=oe2zjRb51F0&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=9
- Reference: https://kubernetes.io/docs/reference/kubectl/quick-reference/

- **Replication Controller**:
  - It's the legacy version of ReplicaSet
  - It can only manage the resources created using it
  - Creates a new pod as soon as one of the pods crashes based on the **number of replicas mentioned**
  - **OR High Availability is required**
  - Imagine in case the node reaches a point where it can not accomodate any more pods, it **can span multiple nodes**

      ![image](https://github.com/user-attachments/assets/e2c67aa0-e541-4de6-a7f5-7e2c0856d18f)

  - Run command: _**sudo kubectl run nginx --image=nginx --dry-run=client -o yaml > nginx_pod.yaml**_

  - It'll create [nginx_pod.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/nginx_pod.yaml) on the cloudshell machine

  - create [replicationcontroller.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/replicationcontroller.yaml) Please note that in spec--template-- we have copied details from nginx_pod.yaml, as we want to replicate the nginx pods.

  - Run command _**sudo kubectl delete pods nginx**_

  - Now run command: _**sudo kubectl apply -f replicationcontroller.yaml**_ It displays message:

    ![image](https://github.com/user-attachments/assets/3587368c-04ae-4fd7-b1be-681be1f16d39)

  - Now run command: _**sudo kubectl get pods**_ It shows 3 pods are created **because in specs we mentioned replicas: 3**

    ![image](https://github.com/user-attachments/assets/6a2f84a1-3a63-4cc2-87c4-4deaa38e471a)

  - Type command: _**sudo kubectl get replicationcontroller**_ where replicationcontroller is the name of the replication controller

    ![image](https://github.com/user-attachments/assets/21846f93-8f0d-41eb-99a4-13a01a8eaedd)

  - Cleanup: _**sudo kubectl delete -f replicationcontroller.yaml**_

    ![image](https://github.com/user-attachments/assets/b9fafa56-7e1a-4680-8f8b-25f37599b00f)

------------------------------------------------

- **ReplicaSets:**
  - It's the recommended option to manage pods (replication of pods) 

  - One can manage pods based on certain selection criteria (e.g. labels) even though the pods were not created using the same config (yaml) file

  - Let's create [replicaset.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/replicaset.yaml) . As you can observe, 
    - kind: ReplicaSet
    - add "selector" in spec
    - matching criteria e.g. env:demo

  - run command: _**sudo kubectl apply -f replicaset.yaml**_ . It gave an error: **error: resource mapping not found for name: "ngnix-rs" namespace: "" from "replicaset.yaml": no matches for kind "ReplicaSet" in version "v1"
ensure CRDs are installed first**

    ![image](https://github.com/user-attachments/assets/d4db60b5-c700-41ad-ba95-49ae5d97b6cb)

  - The command was successful when the replicaset.yaml was corrected referring to the [stackoverflow](https://stackoverflow.com/questions/64412740/no-matches-for-kind-replicaset-in-version-extensions-v1beta1) solution. (The command _**kubectl explain rs**_ is also helpful)

    ![image](https://github.com/user-attachments/assets/ad9c8899-b15c-40c0-8218-0645d7a1c6f7)

  - Now run the command _**sudo kubectl get pods**_

    ![image](https://github.com/user-attachments/assets/c35790c6-f363-4a26-b1e6-7efbe7458366)

  - If you want to increase the pods, there are three ways i) update replicas in yaml and then apply ii) edit live object by using command: sudo kubectl edit pod <pod name> iii) _**sudo kubectl scale --replicas=3 rs/nginxrs**_

     ![image](https://github.com/user-attachments/assets/d0763dcd-6944-4a60-9679-9939f386de25)

  - using sudo kubectl scale --replicas=3 rs/nginxrs

    ![image](https://github.com/user-attachments/assets/a8340c8a-07a9-496e-8b99-f7e11ae9d92c)

    ![image](https://github.com/user-attachments/assets/19ac786b-8d78-4ada-bdbd-6fef8a5fea08)

  - Clean-up: _**sudo kubectl delete -f replicaset.yaml**_ (please note deleting individual pods doesn't help as it gets created automatically)

    ![image](https://github.com/user-attachments/assets/c711b87d-c402-4c8c-8d38-851ec4d85133)

----------------------------------------------------------------  
- Deployments
  - Deployments manage ReplicaSets, which in turn manages pods

    ![image](https://github.com/user-attachments/assets/4f28eaaf-7489-4f02-9c11-7020376e3f63)

  - Creates pods in rolling update fashion without or with minimal downtime (A pod will be created with new version, then added to the load balancer, then next pod with new version and so on...). The changes can be rolled back as well without downtime

  - Instructions:
    - Create [deployment.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/deployment.yaml) by changing kind: deployment, metadata.name: nginx-deployment, replicas:3 

    - run command: _**sudo kubectl apply -f deploy.yaml**_
 
      ![image](https://github.com/user-attachments/assets/9e099be7-21b6-44f5-ae6d-e41e2f186512)

    - Run command to **display all objects in your cluster**: _**sudo kubectl get all**_
 
      ![image](https://github.com/user-attachments/assets/38e01e6f-750d-4c62-af6c-bbe184d7dc34)

    - **Rollout**
      - Command for **rollout**: _**sudo kubectl set image deployment/nginx-deployment nginx=nginx:1.11-alpine**_
   
        ![image](https://github.com/user-attachments/assets/eaeccd68-cdd6-4861-801f-21387e9b481a)

      - Then type: _**sudo kubectl describe deployment/nginx-deployment | less**_
     
        ![image](https://github.com/user-attachments/assets/d3ea1683-d053-40e8-b312-463169e09034)

        
        ![image](https://github.com/user-attachments/assets/7e25bb2d-9637-48b3-8c86-fc0c5fe85752)
   
        
      - Check the rollout hitory by typing: _**sudo kubectl rollout history deployment/nginx-deployment**_
   
        ![image](https://github.com/user-attachments/assets/75598434-e562-4143-a3e1-287d56212759)


    - **Rollback**
      - Command for **rollback**: **sudo kubectl rollout undo deployment/nginx-deployment**
   
        ![image](https://github.com/user-attachments/assets/8ebd2935-6488-4d5d-9b3c-5c91225ac53d)


      - Check the rollout history: _**sudo kubectl rollout history deployment/nginx-deployment**_ . Please note, it has created the next version (3), not deleted the version2
   
        ![image](https://github.com/user-attachments/assets/de9e652e-f284-4b57-8c60-8752d911c0b8)

      - Type: _**sudo kubectl describe deployment/nginx-deployment | less**_ . It has rolled back to version 1.12 alpine
   
        ![image](https://github.com/user-attachments/assets/c17647f5-0df0-4072-ac19-1c11420db6a7)


      - Cleanup: _**sudo kubectl delete -f deploy.yaml**_          
