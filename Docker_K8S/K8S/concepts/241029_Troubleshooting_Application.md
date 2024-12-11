- Reference: https://www.youtube.com/watch?v=cNPyajLASms&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=38 (15:15)
- Reference: https://www.youtube.com/watch?v=Mil0HUtPg6I&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=39
- Reference: https://github.com/piyushsachdeva/example-voting-app
- Reference: https://kubernetes.io/docs/tasks/debug/debug-application/

- Basics:
  - Docker was the default container run time in earlier versions. Now we have crictl 

  - The git repo above has docker-compose which contains all the objects to be deployed on a cluster like services, pods, nodes, application etc.
  
     ![image](https://github.com/user-attachments/assets/28afd5a2-2f83-4963-94ec-23dce05db6e9)

  - Architecture:

      ![image](https://github.com/user-attachments/assets/82619438-90f4-4489-940f-98028a653b1b)

  - The applications are exposed on ports     

---------------------------------------
Troubleshooting Demo
- crictl is not available on the GCP VM, so let's install it for demo purposes from [github](https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md)

     VERSION="v1.30.0" # check latest version in /releases page
     curl -L https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-${VERSION}-linux-amd64.tar.gz --output crictl-${VERSION}-linux-amd64.tar.gz
     sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
     rm -f crictl-$VERSION-linux-amd64.tar.gz

    ![image](https://github.com/user-attachments/assets/72087781-93d0-47c3-b78c-e25e341c44ee)

- Provide permission to the below file

      sudo chmod 777 /run/containerd/containerd.sock

    ![image](https://github.com/user-attachments/assets/ddbba4af-1551-41b9-b4d8-fa858f26459d)


- 
