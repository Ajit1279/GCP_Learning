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
           - nodePort: 30001 since it has to be in the range 30000 to 31676
           - port: 80
           - targetport: 80
         - **selector** for criteria for matching service ( type _**sudo kubectl get pods --show-labels**_)  

 
    - **ClusterIP**
    - **External names**
    - **Load balancer**
