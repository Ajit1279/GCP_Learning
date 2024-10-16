- References: https://www.youtube.com/watch?v=5vimzBRnoDk&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=16

- Basics:
  - **Taints & tolerations only restricts node from accepting only certain types of pods, but the pod may get scheduled on any other node which doesn't have taint**.
    
  - **Node Affinity** matches the **affinity sets on pods** to that with the nodes to schedule a pod on it. **Unlike taints & tolerations, we can specify multiple conditions.**

  - If the **labels from node are removed**, the **existing pod remains scheduled** there, but **new pods with similar affinity won't be scheduled**    
    
      ![image](https://github.com/user-attachments/assets/b4d50482-b939-49b4-9e16-86ae278c4020)

  - There are two important properties for Node Affinity
    - **requiredDuringSchedulingIgnoredDuringExecution**: **Schedule a pod** on node **only if** the **operator on the node is matching**, so the **pod may stuck in pending state**
    - **preferredDuringSchedulingIgnoredDuringExecution**: 
    - The **last part is same** indicating the properties **do not impact existing pods, only to new pods**
    -  
  -  
   
