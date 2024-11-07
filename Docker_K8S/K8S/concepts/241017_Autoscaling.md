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
  - Pre-requisite is to set-up matrix server as shown in [Requests and Limits](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/241017_Requests_Limits.md)

  -  
