- Reference: https://www.youtube.com/watch?v=P0bogYEyfeI&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=23
- Reference: https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/
- Reference: https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/

- Whenever you run any command, you are **able to run it only if authorised**
- All the required information is available in kubeconfig file. The **default kubeconfig file** is in **$HOME/.kube/config** location
- There can be multiple config files and users can pass it as an argument in the command
- The config file **contains "context" which includes cluster and user** indicating the accesses level for users

- Please note the difference between authentication and authorization
  - **Authentication** discussed in previous video
  - **Authorization:**
    - **ABAC**: Attribute Based Access Control. This is tedious because this config needs to be updated each time there's a new user 
    - **RBAC**: Role Based Access Control. This is best practice. We create a role and assign it to user / group of users.
    - **NODE**: Used by nodes to interact with each other
    - **Webhook**: Uses third party such as Open Policy Agent to do authorization. OP Agent is installed on the server   
   

- Demo 
  - create a VM instance and create kind clusters dev and test on it (delete cluster using command: sudo kind delete cluster --name kuberlearn)
    
          sudo kind create cluster --name dev 
          sudo kind create cluster --name test

      ![image](https://github.com/user-attachments/assets/538e8f23-25a3-40c3-aa42-c069f3333d7d)

  - Display the clusters:

          sudo kubectl config get-clusters

      ![image](https://github.com/user-attachments/assets/9e6aa9b6-a5ff-4595-8348-391835a59bd2)


  - Run the command:

          sudo kubectl config view | less
   
      ![image](https://github.com/user-attachments/assets/f33cc9e4-572d-455b-b3ca-75e3c1565a9c)

    
  - Enter these commands to add cluster details to your configuration file:

          sudo kubectl config --kubeconfig=kubeconfdemo set-cluster dev --server=https://1.2.3.4 --certificate-authority=fake-ca-file
          sudo kubectl config --kubeconfig=kubeconfdemo set-cluster test --server=https://5.6.7.8 --insecure-skip-tls-verify

      ![image](https://github.com/user-attachments/assets/99f8666d-4791-477b-8b28-033449711746)

  - Add user details to your configuration file (adding password to the config file is not recommended, but this is just a demo!!)

          sudo kubectl config --kubeconfig=kubeconfdemo set-credentials developer --client-certificate=fake-cert-file --client-key=fake-key-seefile
          sudo kubectl config --kubeconfig=kubeconfdemo set-credentials experimenter --username=exp --password=some-password

      ![image](https://github.com/user-attachments/assets/156bbd25-afb0-46ab-876c-1b07aa25f182)

  - Add context details to your configuration file:

          sudo kubectl config --kubeconfig=kubeconfdemo set-context dev-frontend --cluster=dev --namespace=frontend --user=developer
          sudo kubectl config --kubeconfig=kubeconfdemo set-context dev-storage --cluster=dev --namespace=storage --user=developer
          sudo kubectl config --kubeconfig=kubeconfdemo set-context exp-test --cluster=test --namespace=default --user=experimenter

      ![image](https://github.com/user-attachments/assets/89ae73d2-15e5-4184-bb48-a918f0b99792)

  - Type command to view the config file

           sudo kubectl config --kubeconfig=kubeconfdemo view | less

      ![image](https://github.com/user-attachments/assets/357fcd17-cc65-44cf-8d93-826a1bb78816)

      ![image](https://github.com/user-attachments/assets/f7abc3c5-5d67-4bc5-b373-d33077c97b36)


  - Type command:

          sudo docker ps | grep control-plane

      ![image](https://github.com/user-attachments/assets/e6a549fb-112c-4b77-a1f0-26f33ac222d0)

        
  - Type below commands:

          sudo docker exec -it dev-control-plane bash
          cd /etc/kubernetes/manifests
          ls -lrt
          cat kube-apiserver.yaml | grep auth

      ![image](https://github.com/user-attachments/assets/10e26ce6-320d-4d70-b389-b5acee124c33)

    As shown above it'll first check if the user has any Node based authorization, and if not found, it'll skip to the next one, which is RBAC.   

    
  -   d
  -   sd
  -   sd
