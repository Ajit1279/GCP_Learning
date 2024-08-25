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

  - Create a directory and then config.yml

  - Type the command: _**sudo kind create cluster --config=config.yml**_

    Once created it displays:
    ![image](https://github.com/user-attachments/assets/730cd693-28d9-4340-81f0-cec9e60f6077)
    
  -  
