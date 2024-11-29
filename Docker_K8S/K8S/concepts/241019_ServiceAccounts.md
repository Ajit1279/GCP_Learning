- Reference:
  - https://www.youtube.com/watch?v=k2iCq7IlMKM&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=26
  - https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
  -  

- Basics:
  -  Service Accounts are used by applications

- Demo
  - As a pre-requisite, create VM, install Docker, Kubectl and kind cluster on it

  - 5 default service accounts get created when you create a cluster. 

          sudo kubectl get sa
          sudo kubectl get sa -A | grep default

      ![image](https://github.com/user-attachments/assets/f4646157-d914-4f96-a0e5-01b48bdf32f3)

      ![image](https://github.com/user-attachments/assets/708b3ce8-44d2-49b7-bef0-39b2bf2555a9)

  - Type the below command to check the yaml for default service account

          sudo kubectl get sa default -o yaml

      ![image](https://github.com/user-attachments/assets/2f1c18b5-8985-4db4-a9d1-5ed5dd0d0935)

  - Now let's create our own service account, as the default service accounts have restricted permissions

         sudo kubectl create sa test-sa
         sudo kubectl describe sa test-sa

      ![image](https://github.com/user-attachments/assets/6cd053f8-b8b1-4b5e-beeb-a2df3a8d906b)

      ![image](https://github.com/user-attachments/assets/50c29ebe-f2ec-49ad-a782-c4913bc3dee8)

  - Let's create [sa-secret.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/sa-secret.yaml) by referring to the [documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#manually-create-a-long-lived-api-token-for-a-serviceaccount). Please note that we have **added our service account name in annotations**


          sudo kubectl apply -f sa-secret.yaml
          sudo kubectl get secret

      ![image](https://github.com/user-attachments/assets/a03a3b7f-fe85-4de9-a6da-f9f8afb286a9)

  - Type below command to open the newly created secret. You can observe that it has ca.crt, token and namespace. You'll observe in the below steps that it's mounted as a volume to the pod, once created

          sudo kubectl describe secret/test-sa-secret

      ![image](https://github.com/user-attachments/assets/9dd9d92b-bc67-4391-b290-229904e877d8)

  - Image pull secrets are used to pull images from private repositories such as your org internal repo or cloud repos such as gcr

  - Type the command to check if service account can access pod

          sudo kubectl get pods --as test-sa
          sudo kubectl auth can-i get pods --as test-sa

      ![image](https://github.com/user-attachments/assets/08af6572-9b46-4187-b3f1-2e1838e456f3)

  - As discussed in previous topics, we'll have to create a role 

          sudo kubectl create role test-sa-role --verb=list,get,watch --resource=pod

      ![image](https://github.com/user-attachments/assets/37553052-2d3b-4fcd-a54d-b982f174616a)
 
  - And also role binding
     
          sudo kubectl create rolebinding test-sa-rolebind --role=test-sa-role --user=test-sa

      ![image](https://github.com/user-attachments/assets/3decb11b-2bb6-4417-8910-2d4d5befe5eb)

  - Let's check the result of below command again:

          sudo kubectl auth can-i get pods --as test-sa

      ![image](https://github.com/user-attachments/assets/d7f87720-5408-48bc-88ae-9e844e7c003e)

  - Let's create a pod

          sudo kubectl run nginx --image=nginx

      ![image](https://github.com/user-attachments/assets/375fb8fe-3fc1-4478-9475-88a50e239a4a)

  - Check if service account can access the newly created pods

          sudo kubectl get pods --as test-sa

      ![image](https://github.com/user-attachments/assets/354f6a89-7abb-4cce-af40-aa423d769053)

  - Type the command to open the pod

          sudo kubectl describe pod/nginx | less

      - It shows the default service account
        
         ![image](https://github.com/user-attachments/assets/571d1bf9-b185-4362-b6ca-3f29e4d29a7a)

      - The token is not ingested into pod, but it will be accessed securely from /var/run/secrets/kubernetes.io/serviceaccount which is mounted as volume, one of the best practices.
 
         ![image](https://github.com/user-attachments/assets/f6cd1fb4-d122-4c92-bcf1-c6ebe2890687)

      - ssh into pod. We can observe that it has three values: **A token, namespace and ca.crt**

            sudo kubectl exec -it nginx -- bash
            cd /var/run/secrets/kubernetes.io/serviceaccount

         ![image](https://github.com/user-attachments/assets/6e73a27d-8fc4-4493-bf0b-bd323bfaa0f9)

        
