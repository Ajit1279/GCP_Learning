- Reference: https://www.youtube.com/watch?v=EkAzMGldC5M&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=33
- Reference: https://github.com/containernetworking/cni
- Reference: https://github.com/saiyam1814

- Basics:
  - Docker is about 10 years old now and Docker was the only container run time option to containerise and bundle Kubernetes

  - Gradually things evolved and more & more tools were available. OCI (Open Container Initiative) was a result of this.

  - **Docker** re-architected to comply with OCI
    - When you do Docker Run, the request goes to Docker Daemon
    - **Daemon** or **containrd** does not start container. Containerd only keep a check on lifecycle of the container
    - **Shim**: It passes the request to **runc**. It maintains connectivity between running containers
    - **runc** is compliant to OCI initiative. It is short-lived. It starts the container and exists

  - **Kubectl**
    - When you do a kubectl run you get a node which contain kubelet and CRI
    - **CRI:** Container Runtime Interface
    - It follows the process similar to above and it passes the control to CNI (Container Network Interface)
    - There's no default network when you set-up a kubernetes cluster, node etc. It gives you option to plugin and use networking interfaces.
    - As we know already each pod can communicate with the other pod and each pod has unique IP. CNI does lot of background processing to make this happen
    - In the last session we talked about few plugins like Weave, Calico, Flannel and Cilium (it's most popular)
    - CNI has bare mimimum specification required to set-up network policies to run the K8S
    
  - When you create a container, a network namespace (netns) get created. This enables communication amongst multiple containers within a pod  

  - Inter-node pod communication happens via ethernet (etho) created for each pod. The Root NS bridges these as shown below:

    ![image](https://github.com/user-attachments/assets/38dd7160-df9b-4289-b772-e04f2a4a4bff)

--------------------------------------------------------

