- Reference: https://www.youtube.com/watch?v=cNPyajLASms&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=38 (15:15)
- Reference: https://www.youtube.com/watch?v=Mil0HUtPg6I&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=39
- Reference: https://github.com/piyushsachdeva/example-voting-app
- Reference: https://kubernetes.io/docs/tasks/debug/debug-application/
- Reference: https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl

- Basics:
  - Docker was the default container run time in earlier versions. Now we have crictl (It's not available by default) 

  - The git repo above has docker-compose which contains all the objects to be deployed on a cluster like services, pods, nodes, application etc.
  
     ![image](https://github.com/user-attachments/assets/28afd5a2-2f83-4963-94ec-23dce05db6e9)

  - Architecture:

      ![image](https://github.com/user-attachments/assets/82619438-90f4-4489-940f-98028a653b1b)

  - The applications are exposed on ports     

---------------------------------------
Troubleshooting Demo
- The code in the [git repostory](https://github.com/piyushsachdeva/example-voting-app) has error deliberately introduced in it so that we can troubleshoot

- Create a [VM, install docker, kind, kubectl](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md) on it.

    ![image](https://github.com/user-attachments/assets/c8dfda75-bdfa-4355-ab1f-7abc20210d14)


- To login to the control plane enter the commands

          sudo docker exec -it kuberlearn-control-plane sh
  
    ![image](https://github.com/user-attachments/assets/8b00e76d-ca2c-4bd1-b822-62c824fef2b6)


- Check all running containers

      crictl ps

    ![image](https://github.com/user-attachments/assets/a892903e-a2e1-47f5-8469-800fdc9a4e1b)


- Before cloning the github repository, we'll need to install git on master node. Enter cat /etc/os-release command to check your Linux OS type. 

        cat /etc/os-release
        apt-get update && apt install git
        git --version

    ![image](https://github.com/user-attachments/assets/a9343a91-3344-4d61-aafb-07a108d6aae6)
            

- Now clone the git respository

        git clone https://github.com/piyushsachdeva/example-voting-app

    ![image](https://github.com/user-attachments/assets/860f0478-6b41-41c4-a131-f705e23a245a)

- Enter the below commands. The last command applies all the yaml files in one command

         ls -lrt
         cd example-voting-app
         cd k8s-specifications
         ls -lrt
         sudo kubectl apply -f .
  
- There was an error while appying networkpolicy.yaml.  

    ![image](https://github.com/user-attachments/assets/a9e4de8e-17de-447e-9838-5411739d72cd)


- Let's troubleshoot, As observed in below images network policy yaml does not contain apiversion also it is looking for redis pod with label as "frontend" 
  
        cat networkpolicy.yaml
        kubectl get pods

    ![image](https://github.com/user-attachments/assets/ae0c2da1-f09f-4c7e-9045-30faf3375f27)
    
- Let's describe the redis pod

        kubectl describe pod/redis-77fccb7f9-lxp7n | less

    ![image](https://github.com/user-attachments/assets/3dfde75d-71f8-4f65-a208-4318a61cd608)


- Let's check if any other errors. All the deployments, pods and services are healthy

        kubectl get deploy
        kubectl get pods
        kubectl get svc

    ![image](https://github.com/user-attachments/assets/8b6ee3ba-cdbe-4e2b-a21a-e4737d647bd0)

- Let's check the network policy. It gave an error as expected

         kubectl get netpol

    ![image](https://github.com/user-attachments/assets/20a1f81b-3851-460a-aa20-053aa9e6058e)

- Let's create the [networkpolicy.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/nwpold37.yaml) again by copying and then control-d and apply again

        rm networkpolicy.yaml

        cat > networkpolicy.yaml
        apiVersion: v1
        kind: NetworkPolicy
        metadata:
          name: access-redis
        spec:
          podSelector:
            matchLabels:
              app: redis
          ingress:
          - from:
          - podSelector:
              matchLabels:
              app: "redis"

        kubectl apply -f networkpolicy.yaml
  
- It gave an error again "error: resource mapping not found for name: "access-redis" namespace: "" from "networkpolicy.yaml": no matches for kind "NetworkPolicy" in version "v1""

    ![image](https://github.com/user-attachments/assets/918170c0-9b58-4126-826c-610f990cd91e)

    
- Referring to the [kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/network-policies/#networkpolicy-resource), the apiVersion should be networking.k8s.io/v1 . It worked successfully!!

    ![image](https://github.com/user-attachments/assets/a59d5dd0-2b32-4a3e-aab4-12b3c7abc910)


        kubectl get netpol

    ![image](https://github.com/user-attachments/assets/037c22e6-3188-443b-8deb-82b9247cd490)

      
- So our application set-up is complete. Let's try to access it
- ds
- ds
- ds
- d
- sd
