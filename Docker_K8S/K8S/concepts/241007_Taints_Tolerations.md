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
