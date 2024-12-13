- Reference: https://www.youtube.com/watch?v=cNPyajLASms&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=38 (15:15)
- Reference: https://www.youtube.com/watch?v=Mil0HUtPg6I&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=39
- Reference: https://github.com/piyushsachdeva/example-voting-app
- Reference: https://kubernetes.io/docs/tasks/debug/debug-application/
- https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl

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

    ![image](https://github.com/user-attachments/assets/1a06e8a3-3720-48be-946a-e2b107d0dde0)

- To login to the control plane enter the commands

          sudo docker exec -it kuberlearn-control-plane sh
  
    ![image](https://github.com/user-attachments/assets/5eb53c04-f80f-428a-a4aa-a44821821edd)

- Check all running containers

      crictl ps

    ![image](https://github.com/user-attachments/assets/5b605e3c-d133-4029-8a10-a7baadd457aa)

- 
        
          
-  
