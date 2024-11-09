- Reference: https://www.youtube.com/watch?v=afUL5jGoLx0&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=18

---------------------------------------------------------- 

- Basics:
  - There are two types of autoscaling:
    - Horizontal: Multiple pods with the same specifications will be created.
    - Vertical: New pod with higher specifications is created. Useful for the non mission critical workloads

  - Event based autoscaling: e.g. when there are many 502 errors, using tools like KEDA
  - Cron / Schedule based autoscaling   

      ![image](https://github.com/user-attachments/assets/cd296cb1-c7ce-4d3b-be3f-a8329dd24fdf)

  - As observed in the above diagram, the scaling is on Infra (nodes) and workload (pods)
  - **Workload / Pod Auto scaling** is achieved **using HPA (Horizontal Pod Autoscaling) or VPA (Vertical Pod Autoscaler)**, which is inbuilt to K8S and takes the matrix from matrix server
  - **Cluster Autoscaler** enables the **Horizontal infra / Node auto scaling**
  - **Node Auto Provisioning** helps to enable Vertical Autoscaling **i.e. add more Node Pools to the cluster**
  - Out of all these:
    - **Only HPA is available within K8S by default**.
    - **VPA is a seperate project on github and needs to be installed from there**.
    - **Cluster Autoscaler and Node Auto Provisioning** is available with **cloud providers' managed service e.g. GKE**
   
--------------------------------------
- **Demo**
  - [Create a compute VM and install docker, kubectl and kind cluster on it](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md)
     
  - Pre-requisite is to set-up matrix server as shown in [Requests and Limits](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/241017_Requests_Limits.md).

     ![image](https://github.com/user-attachments/assets/f4fa9883-0d7f-4a9e-8311-a947f6038cbb)

  - Create [Deploy.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/Deploy.yaml) and run command: **sudo kubectl apply -f Deploy.yaml**

      ![image](https://github.com/user-attachments/assets/3b621001-85df-4cd2-8f61-f641a74120e4)

  - Type **sudo kubectl get pods**

      ![image](https://github.com/user-attachments/assets/5110d2b4-eecd-4dfe-bf0a-f92eace6030f)

  - Type: **sudo kubectl get svc**

     ![image](https://github.com/user-attachments/assets/60f85ffd-fc10-4981-aed3-1bc12d0b0b03)

  -  Next we have to create HPA object: autoscale deploy <name of the deployment> --cpu-percent=<nn> --min=<min no. of replicas> --max=<max no. of replicas> . So in our case it is **sudo kubectl autoscale deploy php-apache --cpu-percent=80 --min=1 --max=5**
 
     ![image](https://github.com/user-attachments/assets/0a4a2cf1-280f-49a6-94e3-ea5883428954)

  - Type: **sudo kubectl get hpa**

     ![image](https://github.com/user-attachments/assets/e19af0e3-4435-4035-8e58-4ec767c01bf1)

  - To simulate a load on the application by referring [documentation](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/#increase-load)
     - Open a new terminal and type: **sudo kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"**
 
       ![image](https://github.com/user-attachments/assets/7eb9b241-bac5-4618-bd0a-720a45bf1d28)

     - Now if you type **sudo kubectl get hpa** it shows cpu utlization as 117%
 
       ![image](https://github.com/user-attachments/assets/8a05d1c6-12be-49f9-a22d-9162256fe786)

     - type: **sudo kubectl get hpa --watch**
 
       ![image](https://github.com/user-attachments/assets/3c72a436-2f91-4a8f-9dae-28c2c1ebacef)

     - Type **sudo kubectl get pods**. It shows 5 pods running
 
       ![image](https://github.com/user-attachments/assets/e565ce34-0528-4713-85e7-4e62a5a0e64e)

     - Let's stop the load by entering **Control+ C** in the other window
 
       ![image](https://github.com/user-attachments/assets/12225a1f-7a32-4486-a0b9-edf00216ba43)

     - **sudo kubectl get pods** shows 5 pods stil as it takes some time
 
       ![image](https://github.com/user-attachments/assets/16ea0b03-2bf0-44b7-a16c-a434f02afcec)

     - **sudo kubectl get hpa**. CPU utlilization is 0 now.
 
       ![image](https://github.com/user-attachments/assets/f7907a67-a878-455e-b5ff-332ee53e334b)

     - Let's type  **sudo kubectl get pods** again and after few mins, there's only one pod is running

       ![image](https://github.com/user-attachments/assets/6bdf78db-e692-4209-b478-af717521dfe9)

