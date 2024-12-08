- Reference: https://www.youtube.com/watch?v=2NzYX8_lX_0&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=30

- Basics:
  - The concepts to be covered are: Persistent Volume (PV), Persistent Volume Claim (PVC) and Storage Class (SC) 
  - Inside container we add volume mount to save the data in it, the path for it
  - We also need to specify storage, (e.g. empty directory, which is temporary storage persistent until the lifecycle of the pod)
  - Hence there's Persistent Volume and binding will be created with pod as long as capacity is available and other specifications like access mode (read-write once etc.) are matching
  - Storage Class: Physical storage type where the data is stored
  - Static Provisioning: we have to specify the volume details.
  - Dynamic Provisioning: We don't have to specify persistent volume
  - Multiple PVCs can be attached  with a single PV till storage is available. We can not allocate multiple PVCs to a single PV.

    ![image](https://github.com/user-attachments/assets/4611a1e4-995f-481d-8471-65bf2d8df564)


-----------------------------------------------------------
Demo
- [Create compute instance VM, install Docker, Kubectl and kind cluster on it](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md)

-  

