- Reference: https://www.youtube.com/watch?v=nwoS2tK2s6Q&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=15

- **Taint** means **contaminate or pollute** 
- Suppose we want to run a specific type of workload (e.g. AI/ML models), then **node is tainted** with say **gpu=true**
- So if the scheduler tries to schedule a pod on this node it'll be rejected by node
- We'll need to **add toleration to the pod (gpu=true)** if we want the nodes to accept the pod.

    ![image](https://github.com/user-attachments/assets/88772742-9e0f-4d24-9593-269216694beb)

- There are **three scheduling types** for taints and tolerations:
  - **NoSchedule:** Works on newer pods
  - **PreferNoschedule:** No guarantee
  - **NoExecute:** existing / newer pods

- **Demo**
  - Create a cluster with multiple nodes
  - Run the command **sudo kubectl get nodes**

    ![image](https://github.com/user-attachments/assets/987e792c-b200-485a-a32d-7d1a338835f2)

  - To "taint" the node, type command: **sudo kubectl taint node kubedemo-worker gpu=true:NoSchedule** and **sudo kubectl taint node kubedemo-worker2 gpu=true:NoSchedule** and **sudo kubectl taint node kubedemo-worker3 gpu=true:NoSchedule**

   ![image](https://github.com/user-attachments/assets/10e31142-6461-4f09-9b61-8935fa547f55)

  - To display the taints on nodes, type: **sudo kubectl describe node kubedemo-worker | grep -i taint**

    ![image](https://github.com/user-attachments/assets/7f02dca1-c423-470e-b0f1-bdc51b37eaba)

  - Now let's try to schedule a pod: **sudo kubectl run nginx --image=nginx** and **sudo kubectl get pods**

    ![image](https://github.com/user-attachments/assets/0091a09b-e666-46ad-8dcf-5474adff67ae)

  - As observed above, the pod is still in pending status 
  - 
  - 
 
  
- To remove the taint from the nodes, run: **sudo kubectl taint node kubedemo-worker gpu=true:NoSchedule-**

    ![image](https://github.com/user-attachments/assets/286c9bcc-6dec-4df1-8116-246e87527acb) 
