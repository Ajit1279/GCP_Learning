- Reference: https://www.youtube.com/watch?v=oe2zjRb51F0&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=9
- Reference: https://kubernetes.io/docs/reference/kubectl/quick-reference/

- **Replication Controller**:
  - It's the legacy version of ReplicaSet 
  - Creates a new pod as soon as one of the pods crashes based on the **number of replicas mentioned**
  - **OR High Availability is required**
  - Imagine in case the node reaches a point where it can not accomodate any more pods, it **can span multiple nodes**

      ![image](https://github.com/user-attachments/assets/e2c67aa0-e541-4de6-a7f5-7e2c0856d18f)

- ReplicaSets:
  - Replicasets manage pods (replication of pods) 
  - One can manage pods not created using these replicasets
  - Labels can also be used to match the pod which need to be replicated
    

- Deployments
  - Deployments manage ReplicaSets

    ![image](https://github.com/user-attachments/assets/4f28eaaf-7489-4f02-9c11-7020376e3f63)

  - Creates pods in rolling update fashion without or with minimal downtime
 
