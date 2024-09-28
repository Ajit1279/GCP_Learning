- Reference: https://www.youtube.com/watch?v=kvITrySpy_k&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=13

- **Daemonsets:**
  - In previous exercises multiple pods were created using Replicasets. The pods may or may not be created on three different pods.
  - On the contrary Daemonsets are created on each pod
  - e.g. Daemonset monitoring agent, logging agents, kubeproxy, weave-net, flannel, calico etc.   

- **Daemonset Demo**
  - Create VM, install docker, kubectl and kind cluster on it. 

  - Create [daemonsetdemo.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/daemonset.yaml)

  - Run command: **sudo kubectl apply -f daemonset.yaml**

    ![image](https://github.com/user-attachments/assets/6e169990-8b26-43ec-909e-6d8b1068caa4)


  - Type: **sudo kubectl get pods**  and then **sudo kubectl get nodes**

    ![image](https://github.com/user-attachments/assets/fbc42a5b-2e44-4be8-8f09-c801e65c5421)

  - As you can see **two daemonset pods have been created because there are two nodes** even though we **didn't specify** how many replicas to be created in daemonsetdemo.yaml. The daemonset was not created for control plane, because of taints and toleration (to be covered in future).

  - Run command: **sudo kubectl get ds -A**. There are 3 daemonsets each for kindnet and kube-proxy 

    ![image](https://github.com/user-attachments/assets/24eedeb4-2826-4742-873d-916f9fc0e159)


  - Let's check if there are 3 nodes for kube-proxy. Run command: **sudo kubectl get pods -n kube-system | grep proxy**

    ![image](https://github.com/user-attachments/assets/14ea8a5d-7b53-47ae-aee5-fb8e55c82fc3)

-------------------------------------------
- **[Cronjob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)**
  - Used to run job at a specific time and day

- Create a [cronjob.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/cronjob.yaml) by referring [example](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#example)
  - There are 5 * in the schedule
  - **1st:** Min (0-59)
  - **2nd:** Hour (0-23)
  - **3rd:** Day of the month (1-31)
  - **4th:** Month (1-12)
  - **5th:** Day of the week (0-6) 0 is Sunday, 6 is Saturday  

- Run command: **sudo kubectl apply -f cronjob.yaml**

  ![image](https://github.com/user-attachments/assets/9a012a67-34ca-4729-a543-110407466010)


- Run command: **sudo kubectl get pods** multiple times and you'll observe new hello pod each time

  ![image](https://github.com/user-attachments/assets/b22b16f4-f981-4e2f-bffd-4994621d7335)

---------------------------------------------------------
- Clean-up: 
