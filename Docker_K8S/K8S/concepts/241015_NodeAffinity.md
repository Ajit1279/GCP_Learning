- References: https://www.youtube.com/watch?v=5vimzBRnoDk&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=16

- Basics:
  - **Taints & tolerations only restricts node from accepting only certain types of pods, but the pod may get scheduled on any other node which doesn't have taint**.
  - **Node Affinity** matches the **affinity sets on pods** to that with the nodes to schedule a pod on it. 
    
      ![image](https://github.com/user-attachments/assets/b4d50482-b939-49b4-9e16-86ae278c4020)
   
