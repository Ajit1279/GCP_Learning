- Reference: https://www.youtube.com/watch?v=tHAQWLKMTB0&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=10

- **Services**
  - The [deployments](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/240908_Deployments_ReplicaSets_ReplicationController.md) that we created are not available to internal/external users, as those have not been exposed yet
  - For users to have seamless service, the pods should be able to communicate with each other
  - Example1: Imagine there's front-end, backend and a database. The services makes application loosely coupled
    - The front-end (nginx) can be exposed to the internal / external users
    - The backend (nodejs and database) can be accessed by front-end application only 

    ![image](https://github.com/user-attachments/assets/7a64ce88-034c-4fb8-ac63-1f111803a4e4)

  - There are 4 types of services as explained below:
    - **[1. Nodeport](https://kubernetes.io/docs/concepts/services-networking/service/)**:
      - The application will be **exposed** to the **public users** using a **specific port**
      - **Any** of the ports (default 80) can be used **internally** (**port / target port** in the below diagram), but the **port range for external access** (i.e. **nodeport**) is from **30000 to 32767**. 
      
        ![image](https://github.com/user-attachments/assets/61878b71-23cf-466a-a559-06a0db00e423)

        ![image](https://github.com/user-attachments/assets/d50943e5-024e-4645-80ba-d15d767e03e9)
 
      - **Demo**
        - Create a [deployment](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/240908_Deployments_ReplicaSets_ReplicationController.md)

        - Please note few points while creating [service_nodeport.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/service_nodeport.yaml)
          - **apiVersion**: Run command: _**sudo kubectl explain service | less**_ to find out the apiVersion
          - **kind:** Service
          - **metadata.name:** nodeport-service
          - **spec:** what **type** of service (NodePort in this case)
          - **ports:** the ports which we want to expose
            - nodePort: 30001 since it has to be in the range 30000 to 32767
            - port: 80
            - targetport: 80
          - **selector** for criteria for matching service ( type _**sudo kubectl get pods --show-labels**_)
         
        - Run command: _**sudo kubectl apply -f service_nodeport.yaml**_
     
          ![image](https://github.com/user-attachments/assets/60106126-6544-4eb6-920a-2c78e1ca8922)

        - Run command: _**sudo kubectl get all**_ You can notice that there's a new service: _service/nodeport-service_
     
          ![image](https://github.com/user-attachments/assets/03a2e12b-2471-448d-b91c-2f706f42e2e1)

        - You can run: _**sudo kubectl get svc**_
     
          ![image](https://github.com/user-attachments/assets/bd0d3da2-afc5-4f91-af6f-8e2f447d35db)

        - Now we'll see if we are able to access this service:
          - Run: _**sudo kubectl describe pod nginx-deployment-99786fc58-422z2 | less**_ and note the IP of node
       
            ![image](https://github.com/user-attachments/assets/727a672e-3190-4379-a3a0-3dc12fb41f72)

          - Enter the <IP>:30001 in browser. The service is not reachable
       
            ![image](https://github.com/user-attachments/assets/1b76d784-0847-4070-bb67-107cd66610a9)

          - This requires [additional set-up](https://kind.sigs.k8s.io/docs/user/quick-start/#mapping-ports-to-the-host-machine) in the cluster and the existing cluster can not be amended, so we'll have to create a new cluster and follow the above steps
            
          - Delete the existing cluster: _**sudo kind delete cluster gkedemo**_

          - Create a new [configuration](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/kind_for_service_config.yaml) file  and type command _**sudo kind create cluster --config kind_for_service_config.yaml --name servicedemo**_  
          

 
    - **ClusterIP**
    - **External names**
    - **Load balancer**
