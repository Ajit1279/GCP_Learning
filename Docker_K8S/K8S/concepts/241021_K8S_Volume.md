- Reference: https://www.youtube.com/watch?v=2NzYX8_lX_0&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=30

- Basics:
  - The concepts to be covered are:
    - Persistent Volume (PV) i.e. total storage
    - Persistent Volume Claim (PVC) is the storage we want to request out of the total storage
      - Retain: PV will remain in ,
    - Storage Class (SC) 
  - Inside container we add volume mount to save the data in it, the path for it
  - We also need to specify storage, (e.g. empty directory, which is temporary storage persistent until the lifecycle of the pod)
  - Hence there's Persistent Volume and binding will be created with pod as long as capacity is available and other specifications like access mode (read-write once etc.) are matching
  - **Reclaim Policy**: Indicates what will happen to the PV (storage) when the PVC is deleted
  - Storage Class: Physical storage type where the data is stored
  - Static Provisioning: we have to specify the volume details.
  - Dynamic Provisioning: We don't have to specify persistent volume
  - Multiple PVCs can be attached  with a single PV till storage is available. We can not allocate multiple PVCs to a single PV.

    ![image](https://github.com/user-attachments/assets/4611a1e4-995f-481d-8471-65bf2d8df564)


-----------------------------------------------------------
Demo
- [Create compute instance VM, install Docker, Kubectl and kind cluster on it](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md)

- Create [pv.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/pv.yaml) and [pvc.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/pvc.yaml) and apply using kubectl command

       vi pv.yaml
       vi pvc.yaml
       sudo kubectl apply -f pv.yaml
       sudo kubectl apply -f pvc.yaml

    ![image](https://github.com/user-attachments/assets/df1b1a65-c1ec-4b15-bc44-fbcda35de7d4)

- Display the pv and pvc

       sudo kubectl get pv
       sudo kubectl get pvc

     ![image](https://github.com/user-attachments/assets/b93035b0-504a-4ed2-b8c7-293b16d9a6ab)

- The pvc is in pending state. let's debug

      sudo kubectl describe pvc/task-pv-claim

    ![image](https://github.com/user-attachments/assets/2b0974e1-1331-427c-9d38-b05f510ec80c)

- Confirmed that accessModes in pv and pvc is the same. Let's delete the pvc before modifying pvc yaml

      sudo kubectl patch pvc task-pv-claim -p '{"metadata":{"finalizers": []}}' --type=merge
      sudo kubectl delete pvc/task-pv-claim

    ![image](https://github.com/user-attachments/assets/49bb2b07-4659-454a-ad20-a220b3b152de)
  
-  
-    

