- Reference: https://www.youtube.com/watch?v=Q9fHJLSyd7Q&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=20
- Reference: https://kubernetes.io/docs/concepts/configuration/configmap/
- Reference: https://kubernetes.io/docs/concepts/configuration/secret/

- **Basics:**
  - **Configmaps:** It helps to "parameterise" various variables and then inject those values in K8S objects

  - One of the approaches is to mention literals if the numbers is not large 

      ![image](https://github.com/user-attachments/assets/e6c4c217-6e1f-402e-a040-85926b0a9ad2)
    
  - The configmap file can be used directly in the yaml, but the best practice is to mount it as a volume in the **spec.env section**

  - Another option is to mention key value pairs in a file and refer that file. The key value pairs are stored in "Data" section of yaml

      ![image](https://github.com/user-attachments/assets/62470d24-2af6-4915-b114-6afa1e46a484)
     
-------------------------------------------------------
- Demo
  - Create [cmdemo1.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/cmdemo1.yaml)
 
  - The approach we followed so far was something like:

    -  Run command **sudo kubectl apply -f cmdemo1.yaml** and **sudo kubectl get pods**

        ![image](https://github.com/user-attachments/assets/e2537dfb-d483-4381-ae67-0e7a42399638)

    - ssh into container: **sudo kubectl exec -it cmdemo1-pod -- sh** and print the variable **echo $FIRSTNAME**. As shown, it displays the value

        ![image](https://github.com/user-attachments/assets/8dec5dcc-7f46-4e2a-bb9e-5a90a38039fe)

  - Now let's create a configmap, which can be created using the imperative and declarative way.

  - **Imperative** 

    - Type the below command and hit enter. 
      **sudo kubectl create cm cmdemo --from-literal=firstname=John \
      --from-literal=lastname=Doe**
 
        ![image](https://github.com/user-attachments/assets/e82da4ea-2d3b-475c-af3b-316ebfe0b5da)

    - Configmap **cmdemo** is created. Type **sudo kubectl describe cm/cmdemo**
 
       ![image](https://github.com/user-attachments/assets/57549a3d-ea61-4074-afb1-c5d42b9ba57b)

    - Create [cmdemo2.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/cmdemo2.yaml). **FIRSTNAME** in container spec refers to **firstname in the configmao cmdemo** 

    - Type command: **sudo kubectl apply -f cmdemo2.yaml**
 
        ![image](https://github.com/user-attachments/assets/f4ad7ebc-bdcb-4386-ae79-b7983e968791)

    - ssh into pod and print the value: **sudo kubectl exec -it cmdemo2-pod -- sh** and print the variable **echo $FIRSTNAME**. As shown, it displays the value
 
        ![image](https://github.com/user-attachments/assets/e4cfceca-e0fd-4d5e-97f6-97e41c7e35ab)

  - **Declarative**
    
    - Refer [documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/) for the declarative ways of creating configmaps

  
