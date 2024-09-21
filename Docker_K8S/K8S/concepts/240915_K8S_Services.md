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
       
             ![image](https://github.com/user-attachments/assets/538cd958-48d0-4616-8f44-e381d53710ee)

          - Now let's follow steps above
            - Run command: **sudo kubectl get all**
         
               ![image](https://github.com/user-attachments/assets/6aed054b-899d-4170-ad5b-692cbfad8bd5)

            -  Run command: _**sudo kubectl describe pod/nginx-deployment-78467fc744-csdln | less**_ . Note the IP of the node: Node:servicedemo-worker2/172.18.0.3
           
                ![image](https://github.com/user-attachments/assets/2f9f95e3-277a-4009-92c5-7ccbee7527b5)

            - Run command: _**curl 172.18.0.3:30001**_ or **curl localhost:30001** .The service is successfully created.
         
              ![image](https://github.com/user-attachments/assets/be9a6c16-c753-45b0-8cbf-40d740354a9c)

            - **Command:** **sudo kubectl describe svc nodeport-service**
         
              ![image](https://github.com/user-attachments/assets/20b71f8f-2413-4527-a339-77e736384df7)

         
 
    - **ClusterIP**
      - The IPs of pods, nodes or any other backend components may not be static, Cluster IP comes handy in such cases
 
        ![image](https://github.com/user-attachments/assets/8728b0ec-8a49-4406-874b-a18652107f15)
 
      - **Demo**
        - Create [clusterip.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/clusterip.yaml)
          - metadata.name : clusterip-service
          - spec.type: ClusterIP
          - Remove Nodeport : 30001

        - Run command: _**sudo kubectl apply -f clusterip.yaml**_ and then _**sudo kubectl get svc**_
     
          ![image](https://github.com/user-attachments/assets/64a52db5-3f57-416d-9b72-78ffeaf54082)

        - Command _**sudo kubectl describe svc/clusterip-service**_ and then _**sudo kubectl get pods -o wide**_ . Please note that endpoints of service and the pod IPs are same i.e. clusterip is listening on these IPs and port 80 (which we specified in our clusterip.yaml)
     
          ![image](https://github.com/user-attachments/assets/810931d0-1be5-4717-a301-da581fcede40)

        - Further let's type: _**sudo kubectl get ep**_
     
          ![image](https://github.com/user-attachments/assets/60d4cae0-c651-468a-afae-c627f39761e6)

    
    - **Load balancer**
      - Convenient way to expose application to users rather than individual IPs, as those may change and also those would be too many for large applications
   
         ![image](https://github.com/user-attachments/assets/a5e5e3ef-5ee8-4d83-aa8f-a5483ae1ff7b)

      - Create [loadbalancer_svc.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/loadbalancer_svc.yaml)
        - Type: LoadBalancer
        - metadata.name: loadbalancer-service

      - Command: _**sudo kubectl apply -f loadbalancer_svc.yaml**_ and then _**sudo kubectl get svc**_
   
         ![image](https://github.com/user-attachments/assets/c59c2a44-3d7a-40ba-9daf-512e32763ae5)

      -  Please note that it does not have external IP because we have not provisioned external LB in this kind cluster. For more information to create a LoadBalancer in kind cluster refer the [documentation](https://kind.sigs.k8s.io/docs/user/loadbalancer/)
        - Create [kindlb.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/kindlb.yaml)
        
        - Run Command: _**sudo kubectl apply -f kindlb.yaml**_
   
          ![image](https://github.com/user-attachments/assets/50055ea6-6097-4561-85af-b0166378d6d4)

        - Run command: _**sudo kubectl get svc**_
   
          ![image](https://github.com/user-attachments/assets/018cd274-014e-4084-b699-58d6097a5b93)

        - **It's not working still (Task for some other day!!** :) )
 
          ![image](https://github.com/user-attachments/assets/788cf411-cd90-43fd-8721-974bb9afcd75)

           
    - [**External names**](https://kubernetes.io/docs/concepts/services-networking/service/#externalname)
      - Create [externalname.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/externalname.yaml)
        - instead of labels, we map it to a DNS (my.database.example.com)

      - Command: _**sudo kubectl apply -f externalname.yaml**_
   
        ![image](https://github.com/user-attachments/assets/268c6b76-d0d7-4920-80af-e1eda3168c2d)

      - It created the service, but not accessible 
   
        
      -  
