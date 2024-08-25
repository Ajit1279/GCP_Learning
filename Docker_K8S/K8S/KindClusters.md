- Reference: https://www.youtube.com/watch?v=RORhczcOrWs&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=7
- Reference: https://medium.com/@binitabharati/setting-up-kind-cluster-9393aacbef43

- We'll be installing Kubernetes cluster on local machine. There are multiple options like minikube, etcd, kind etc.

- [**kind**](https://kind.sigs.k8s.io/): Tool for running local Kubernetes clusters using Docker container “nodes”.

- **Set-up Multinode Clusters** 

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

  -   
