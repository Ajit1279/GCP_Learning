- Reference: https://www.youtube.com/watch?v=Q-mk6EZVX_Q&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=17

- Basics:
  - The pods will be scheduled if sufficient resources available on a node, or it'll encounter an error "insufficient resources"

    ![image](https://github.com/user-attachments/assets/0e341aa7-183c-46cc-a9c1-45c0fc6555f4)

  - Say the pod is scheduled already, but starts consuming all the resources in a node, then node will crash with an error "Out of Memory"

      ![image](https://github.com/user-attachments/assets/d680cbe9-81e0-444b-a195-9be2de89b719)

  - Resources and Limits avoids above situation and pod crashes rather than entire node.

    ![image](https://github.com/user-attachments/assets/741badc3-b5c7-481f-a70b-472445487c00)

-------------------------------------------------
- Demo
