- Reference: https://www.youtube.com/watch?v=2NzYX8_lX_0&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=30

- Basics:
  - The concepts to be covered are:
    - Persistent Volume (PV) i.e. total storage

    - Persistent Volume Claim (PVC) is the storage we want to request out of the total storage
   
    - Storage Class (SC) 
   
    - Inside container we add volume mount to save the data in it, the path for it
   
    - We also need to specify storage, (e.g. empty directory, which is temporary storage persistent until the lifecycle of the pod)
   
    - Hence there's Persistent Volume and binding will be created with pod as long as capacity is available and other specifications like access mode (read-write once etc.) are matching

    - **Multiple PVCs** can be attached **with a single PV** till storage is available. We can **not allocate single PVCs to a multiple PVs**. 

   - **Reclaim Policy**: Indicates what will happen to the PV (storage) when the PVC is deleted
      - **Retain:** PV will remain in released status and no other PV can request data from it
      - **Delete:** The PV will be deleted as soon as PVC is deleted
      - **Recycle:** The PV will become available to other PVCs as soon as the PVC is deleted

   - **Storage Class:** If the physical storage type is not a local then storage class is created as a reference to the storage provisioned on cloud, data center etc. as shown below
     - **Static Provisioning:** We have to specify the volume details.
     - **Dynamic Provisioning:** We don't have to specify persistent volume. It'll automatically create PV and PVC for you.
     

    ![image](https://github.com/user-attachments/assets/4611a1e4-995f-481d-8471-65bf2d8df564)


-----------------------------------------------------------
Demo
- [Create compute instance VM, install Docker, Kubectl and kind cluster on it](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md)

    ![image](https://github.com/user-attachments/assets/b3b934f7-f94a-4fef-b2dc-4b8224668103)

- Create redis pod using [redis.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/redis.yaml)
  - volumeMounts: It's added because we want to store data in this container
  - mountPath: The data has to be stored somewhere in the pod
  - volume name should be same as volumeMounts
  - empty directory: because this is not persistent data, the data will be available till the lifetime of a pod only

        sudo kubectl apply -f redis.yaml
        sudo kubectl get pods

   ![image](https://github.com/user-attachments/assets/fa8aec1d-bcd9-4faf-bb07-9cc9e44a2dc9)

- Let's describe the pod

        sudo kubectl describe pod/redis-pod

    ![image](https://github.com/user-attachments/assets/3433165c-eb64-4926-8170-a7541acdeb1c)

  
- Login to the pod. You can observe that directory with name /data/redis has been created, but there's no data in it. So let's create a file called voldemo.txt

        sudo kubectl exec -it redis-pod -- sh
        cd /data/redis
        ls -lrt
        echo "K8S volume demo" > voldemo.txt
        cat voldemo.txt

    ![image](https://github.com/user-attachments/assets/def65fa6-db8c-4d2f-9f56-3aba0dbdacfb)

- Let's install ps process

          apt-get update && apt-get install procps -y
          ps -aux
 
     ![image](https://github.com/user-attachments/assets/e8506432-b78b-477d-98fb-acf9ea9ad855)
   

- Kill the pod and let's check after the pod is restarted

          ps -9 1
          ps -aux

    ![image](https://github.com/user-attachments/assets/f5a02382-d62c-4ebd-b4de-0b330af58052)

- You can observe that the data exists because the "container" was restarted. The data is maintained on a volume mounted on a pod outside the container. 

- Now let's exit the pod and delete it

        exit
        sudo kubectl delete pod redis-pod

    ![image](https://github.com/user-attachments/assets/3027a72b-0a8f-4bac-a62d-454aa54384bf)

- Apply the yaml to create the pod, login to the pod and check the result. **The file does not exist**

        sudo kubectl apply -f redis.yaml
        sudo kubectl exec -it redis-pod -- sh
        cd /data/redis
        ls -lrt

    ![image](https://github.com/user-attachments/assets/890357f4-3a01-408e-bdca-85cfb9a3d97b)

- This necessiates Persistent Volume and Persistent Volume Claim if the data should be available across the workloads

- Login to the control-plane

        sudo docker exec -it kuberlearn-control-plane sh

- Create [pv.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/pv.yaml) and [pvc.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/pvc.yaml) . Referring to the answer of meijsermans on the [post](https://stackoverflow.com/questions/30853247/how-do-i-edit-a-file-after-i-shell-to-a-docker-container) 

        cat > pv.yaml (copy content of yaml from gitrepo and control-d)
        cat > pvc.yaml ((copy content of yaml from gitrepo and control-d)
        
- Apply using kubectl command

        kubectl apply -f pv.yaml
        kubectl get pv

   ![image](https://github.com/user-attachments/assets/b1b78cea-6e29-4689-98b0-c4e9d66d0153)

         kubectl apply -f pvc.yaml
         kubectl get pvc

   ![image](https://github.com/user-attachments/assets/9702683d-09b9-4d91-a2f0-a7e534d87dfb)

- The pvc is in "pending" state. So we'll need to troubleshoot this. It's showing error (waiting for first consumer to be created before binding)

         kubectl describe pvc

   ![image](https://github.com/user-attachments/assets/0890712f-12bf-45e7-b595-47e3b2587678)

  
- Let's create pods using [voldemopod.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/voldemopod.yaml)

          cat > voldemopod.yaml (copy content and control-d)
          kubectl apply -f voldemopod.yaml

   ![image](https://github.com/user-attachments/assets/665f6354-f819-40ae-809e-510d4524104b)

      
- The status of the pvc is shown as "bound" now

    kubectl get pvc

    ![image](https://github.com/user-attachments/assets/968a4235-8d13-44ff-9f0a-9c131d37f7c3)

    ![image](https://github.com/user-attachments/assets/7ad0c2c7-2f60-4df4-b342-4829182c7850)

- Let's login to the newly created task-pv-pod pod and go to the directory specified in the [voldemopod.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/voldemopod.yaml) (/usr/share/nginx/html)

         sudo kubectl exec -it task-pv-pod -- bash
         cd /usr/share/nginx/html/
         ls -lrt
         curl localhost

  ![image](https://github.com/user-attachments/assets/94a706a6-7a82-4857-91c0-1cab856bcac6)

- The /usr/share/nginx/html/ does not exist hence there are no files returned. also curl command on localhost did not return default nginx display. It needs to be tried by mounting some other path. it's not clear how Day29 folder on local was mapped to the /usr/share/nginx/html/ by Piyush
