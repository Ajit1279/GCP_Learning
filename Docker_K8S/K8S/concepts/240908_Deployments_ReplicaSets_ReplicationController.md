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

  - Type command: _**sudo kubectl get replicationcontroller**_ where replicationcontroller is the name of the yaml file

    ![image](https://github.com/user-attachments/assets/21846f93-8f0d-41eb-99a4-13a01a8eaedd)


- **ReplicaSets:**
  - It's the recommended option to manage pods (replication of pods) 
  - One can manage pods based on certain selection criteria (e.g. labels) even though the pods were not created using this config (yaml) file
  - Let's create replicaset.yaml 
  
    

- Deployments
  - Deployments manage ReplicaSets

    ![image](https://github.com/user-attachments/assets/4f28eaaf-7489-4f02-9c11-7020376e3f63)

  - Creates pods in rolling update fashion without or with minimal downtime
 
