- Reference: https://www.youtube.com/watch?v=RORhczcOrWs&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=7
- Reference: https://medium.com/@binitabharati/setting-up-kind-cluster-9393aacbef43
- Reference: https://github.com/kubernetes-sigs/kind
- kubectl cheat sheet: https://kubernetes.io/docs/reference/kubectl/quick-reference/

- We'll be installing Kubernetes cluster on local machine. There are multiple options like minikube, etcd, kind etc.

- [**kind**](https://kind.sigs.k8s.io/):
  - Tool for running local Kubernetes clusters using Docker container “nodes”.
  - Runs each Kubernetes node as a docker container within our host (physical machine/VM)
  - Kind is **not designed** to support **production grade** Kubernetes cluster.
  - 

- **Set-up Multinode Clusters** (Please refer this for [multi-machine kind cluster](https://github.com/kubernetes-sigs/kind/issues/1928))

  - Run below command to install kind

    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo cp ./kind /usr/local/bin/kind
    rm -rf kind

  - Verify if kind is installed: _**kind --version**_

    ![image](https://github.com/user-attachments/assets/8efc4e55-c369-47f3-9af0-f8579ec579f4)

  - Create a directory (say kind) and then [config.yml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/config.yml) file in it

  - Type the command: _**sudo kind create cluster --config=config.yml**_

    Once created it displays:
    
    ![image](https://github.com/user-attachments/assets/730cd693-28d9-4340-81f0-cec9e60f6077)
    
  -  Type command: _**sudo kubectl cluster-info**_
 
      ![image](https://github.com/user-attachments/assets/8f58fc06-7010-46e0-a33e-c83d9170002d)


  -  It returned error:   

      ![image](https://github.com/user-attachments/assets/b3dae7cc-81ff-4b92-95e1-9b28fafa8055)

  - So let's install latest kubernetes version using below commands:
    - Download the latest release: _**curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"**_
    - Download the kubectl checksum file: _**curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"**_
    - Validate the kubectl binary against the checksum file: _**echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check**_
    - Install kubectl: _**sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl**_
    - Test to ensure the version you installed is up-to-date: _**kubectl version --client**_

      ![image](https://github.com/user-attachments/assets/f214c263-9b7a-49c5-a985-ed07465bfc50)


  - Now let's run the command again: _**sudo kubectl cluster-info --context kind-kind**_ (a cluster with default name "kind" is created)

    ![image](https://github.com/user-attachments/assets/9677dc18-80d6-4e36-bb0b-ade14a42007d)

  - Run the command: _**sudo kubectl get nodes**_ . As observed it's running 1 control plane and 3 workder nodes

    ![image](https://github.com/user-attachments/assets/038ffc46-9117-409c-800c-06eece19537a)

  - Now let's create one more cluster: _**sudo kind create cluster --image kindest/node:latest --name kind1**_   Failed

    ![image](https://github.com/user-attachments/assets/5e388e65-c709-4f98-9091-2c2a4ad85986)

    
  - Let's use [pre-built images](https://github.com/kubernetes-sigs/kind/releases): _**sudo kind create cluster --image kindest/node:v1.28.13@sha256:45d319897776e11167e4698f6b14938eb4d52eb381d9e3d7a9086c16c69a8110 --name kind1**_

  - The cluster "kind1" has been created

    ![image](https://github.com/user-attachments/assets/915539af-494a-4ac6-a7ba-f90e34cc23a7)
    
  - Display it using the context "kind1"

    ![image](https://github.com/user-attachments/assets/babf8e6e-5907-4a96-a1e5-991a10446a48)

  - Run command: _**sudo kubectl get nodes**_ . You can observe that it creates only control plane by default.

    ![image](https://github.com/user-attachments/assets/1dea81a7-460c-4c03-b79d-4b5a71719e10)

  - To display all clusters, run command: _**sudo kubectl config get-contexts**_  The current cluster is **marked with "*"**. **!!!! This is important because otherwise you may perform operations in other cluster inadvertantly !!!** 

    ![image](https://github.com/user-attachments/assets/d6a057c5-398a-4f77-98c0-fc7b24152ff3)


  - **Clean-up (Use carefully as it deletes all clusters)**: _**sudo kind delete clusters --all**_

      ![image](https://github.com/user-attachments/assets/56d1f6ae-ccd0-4b2f-9dd8-df183205c007)

  - **Delete / suspend VM**
