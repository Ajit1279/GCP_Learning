- References: https://www.youtube.com/watch?v=yRiFq1ykBxc&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=12

- **Multi container Pod**:
  - **Init container:**
    - Does certain tasks to initiate an app.
    - It restarts / stops, the init container folloes the same state
    - It shares the resources within the pod

  - **Sidecar / helper container:** Runs all the time with app container and provides input or takes output from the app

  - **Demo**
   - Create [multicontainer_pod.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/multicontainer_pod.yaml)
     - busybox is a general purpose docker image to create containers 
     - spec.command : command to be run within the pod. sleep 3600 ensures that conatiner is not destoyed
     - The arguments can also be passed separately using **spc.initContainer.args**. It continues to run nslookup command to look-up a "myservice" service after every 2 seconds (sleep 2)
     
   - Type command: **sudo kubectl create -f multicontainer_pod.yaml** . It returned an error because I mis-spelled "kind: pod" (P should be capital)

     ![image](https://github.com/user-attachments/assets/8ce00b94-bff0-4c86-9d5c-d648012efb2a)

   - Another error. 

     ![image](https://github.com/user-attachments/assets/820b831e-9e1b-4899-947b-72f15eb7c041)

   - Corrected **I**nitiContainer to **i**nitContainer. Pod is created successfully

     ![image](https://github.com/user-attachments/assets/32db0e0e-b7c1-49f3-bd1f-63facd0c0e11)

   - Run the command: **sudo kubectl get pods**

     ![image](https://github.com/user-attachments/assets/bf7636cf-7588-47d8-82df-ce8ed0b8fa1f)

   - As you can observe, the pods are not ready and init pod is still in initialization status
   
   - Type the command: **sudo kubectl describe pods mymulticontapp | less** and scroll down. **It shows the pod is still initializing state because Init Container is running, but it's still not ready because the condition we mentioned is still not satisfied** 

     ![image](https://github.com/user-attachments/assets/f8117040-3298-447c-bfee-3b786c93e90f)


   - Now type **sudo kubectl logs pod/mymulticontapp**

     ![image](https://github.com/user-attachments/assets/d2045e69-f678-4963-93de-ed97bc6647d5)

   - Type: **sudo kubectl logs pod/mymulticontapp -c init-myservice** . It shows that the service is not yet up

     ![image](https://github.com/user-attachments/assets/04425bd5-aa82-444f-9a4a-e9cce616af84)

   - Now let's create an nginx deployment: **sudo kubectl create deploy nginx-deploy --image nginx --port 80**

     ![image](https://github.com/user-attachments/assets/449121ba-7082-4d7a-9150-b08e58a67512)

   - type: **sudo kubectl get deploy**. T

     ![image](https://github.com/user-attachments/assets/9917a671-02d6-4139-a7ca-1717040e827f)

   - Type: **sudo kubectl get pods**. As you can observe mymulticontapp is still in "init" status

     ![image](https://github.com/user-attachments/assets/84713fb1-78b8-4672-a467-05759ef69e0e)

   - Now let's expose the ngnx service with the name "myservice" as our init pod is doing nskookup on this service and unable to find it, so stuck in initialization status: **sudo kubectl expose deploy nginx-deploy --name myservice --port 80**.

     ![image](https://github.com/user-attachments/assets/b1b7fc40-53bb-4e52-8581-cb6862786003)

   - Now type: **sudo kubectl get pods**, you'll notice that mymulticontapp is now in running status

     ![image](https://github.com/user-attachments/assets/e44af35e-469b-44e3-8465-3ff1f9f7239a)

   - So to **summarise**
     - The init container in our pod tried to initialise by doing nslookup on "myservice" after every 2 sec 
     - But as it couldn't find the "myservice", it was stuck in initialization state
     - So we created an nginx app and exposed the service, which then satified the criteria mentioned in our yaml and pod was initialized

   - Now if you print the logs of init container: **sudo kubectl logs pod/mymulticontapp -c init-myservice**, it shows that it has stopped "waiting for service to be up" as it found the service mentioned in nslookup command

     ![image](https://github.com/user-attachments/assets/be8048a7-c428-4d75-90cc-4a86b45da4ff)
  
   - If we type: **sudo kubectl exec -it mymulticontapp --printenv**, it prints all env variables. Please note that it set the custom variable "purpose=multicontdemo", which we mentioned in our yaml

     ![image](https://github.com/user-attachments/assets/a5dac05f-85ff-49f3-bb77-5a59afb25cd5)

   
   - Type: **sudo kubectl exec -it mymulticontapp -- sh** to enter into container (like SSH)

     ![image](https://github.com/user-attachments/assets/c69954d9-96bb-4c18-aa2c-fe69e6af9b14)

   - Run command: **echo $purpose** to display the variable that we set

     ![image](https://github.com/user-attachments/assets/87fdf769-93fe-432f-b23a-e8c0860c5150)

- One can also create multiple init containers (20:37)
  - Create [multiple_initcontiner_pod.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/multiple_initcontiner_pod.yaml)
    - Replicate init-myservice section and create init-mydb section within the yaml  
 
  - Before applying let's delete the pod created above (mymulticontapp): **sudo kubectl delete pod mymulticontapp**
 
  - Type command: **sudo kubectl apply -f  multinitcont.yaml** . As you can notice one of the containers in mymulticontapp is in init status

    ![image](https://github.com/user-attachments/assets/255bfa7b-90a0-4cc2-a6cc-046906466931)

  - Let's create a service for db using redis image. **sudo kubectl create deploy mydb --image redis --port 80**

    ![image](https://github.com/user-attachments/assets/3de12662-f7e6-4c0e-9f50-89bf8cd8f0d2)

  - expose this deployment: **sudo kubectl expose deploy mydb --name mydb --port 80** followed by **sudo kubectl get pods -w**. Now the app is up

    ![image](https://github.com/user-attachments/assets/ca101407-c92e-42e4-9b05-8f56c1384830)

 - **So we have successfully created a pod with two init containers!** 
