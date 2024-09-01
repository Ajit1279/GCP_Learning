- Reference: https://www.youtube.com/watch?v=RORhczcOrWs&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=7
- Reference: https://medium.com/@binitabharati/setting-up-kind-cluster-9393aacbef43
- Reference: https://github.com/kubernetes-sigs/kind
- kubectl cheat sheet: https://kubernetes.io/docs/reference/kubectl/quick-reference/

- We'll be installing Kubernetes cluster on local machine. There are multiple options like minikube, etcd, kind etc.

- [**kind**](https://kind.sigs.k8s.io/):
  - Tool for running local Kubernetes clusters using Docker container “nodes”.
  - Runs each Kubernetes node as a docker container within our host (physical machine/VM)
  - Kind is **not designed** to support **production grade** Kubernetes cluster.
 
- [Install Docker](https://docs.docker.com/engine/install/debian/) 

- **Set-up Multinode Clusters** (Please refer this for [multi-machine kind cluster](https://github.com/kubernetes-sigs/kind/issues/1928))

  - Run below commands to install kind

    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    
    chmod +x ./kind

    sudo cp ./kind /usr/local/bin/kind

    rm -rf kind

  - Verify if kind is installed: _**kind --version**_

    ![image](https://github.com/user-attachments/assets/8efc4e55-c369-47f3-9af0-f8579ec579f4)

  - Create a directory (say kind) and then [config.yml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/Config_Multinode.yml) file in it

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

---------------------------------------------------------------------
- **Day 7: Pods in kubernetes**
- References: https://www.youtube.com/watch?v=_f9ql2Y5Xcc&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=8

- **Basics**
  - Two ways to create a pod:
    - **Imperative:** Running a command to give instructions to API server e.g. _kubctl run nginx_ , _kubctl get pods_
    - **Declarative:** Create a configuration file. e.g. ([YAML](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/mymanifest.yaml) or JSON) to set the desired state of the object

  - **Instructions**
    - Let's create a VM. Ensure to have **sufficient space in the VM**, so use n1-standard-8 etc.
  
    - Install latest kubernetes version ([instructions](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md))

    - Follow above instructions to create a cluster. Type _sudo kubectl cluster-info_ to display cluster
 
      ![image](https://github.com/user-attachments/assets/67def5fb-f162-4aea-ac1a-4627b7a349f1)

    - Now let's create [pod_create.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/pod_create.yaml) to create a pod
      - File extention can be yml or yaml
      - Preferred way of using configuration file for Prmethus, Docker compose etc
      - yaml supports different data types: lists, dictionary, string, integers etc
      - It has 4 top level properties: apiVersion, kind, metadata, spec (PLease note these are all **case sensitive**)
      - **apiVersion:** can be v1, v2 etc....or beta, alpha
      - **kind:** In this case we have to specify **Pod**
      - **metadata**
        - **name:** name of the pod
        - **labels:** unlike other fields, **it supports any key value pair** 
      - **spec:**
        - **containers:** name of the container (e.g. nginx-container)
        - **image**: which you would like to use for creating containers (say nginx)
        - **ports**: we have specified container port as 80   

    - Let's run command: _sudo kubectl create -f pod_create.yaml_

    - It returned an error:
 
      ![image](https://github.com/user-attachments/assets/33c97db2-30af-498c-a015-82bfb7890631)


    - So modified the pod_create.yaml and ran the command again. It was successful!!
 
      ![image](https://github.com/user-attachments/assets/d3b2fd4a-7215-4522-8795-6ef998ae831a)


    - Now let's corrupt the pod_create.yaml by changing hashicorp/http-echo to hashicorp/http**s**-echo and run the command again _sudo kubectl create -f pod_create.yaml_

    - The pod was created, but if we check the status of the pod by running command _sudo kubectl get pods_ it shows pod is **not ready**
 
      ![image](https://github.com/user-attachments/assets/bbd5fa62-d613-4274-98b7-517883e44141)
 
      ![image](https://github.com/user-attachments/assets/24271616-7c9f-4005-b3d8-5280cd1251a3)


    - The "ImagePullBackOff" means it's facing error while pulling the image.

    - To troubleshoot, type the command: _sudo kubectl describe pod test-pod_

 
      ![image](https://github.com/user-attachments/assets/d3c4a57b-6080-4125-bb3b-cb87e1a66179)


    - So we can update yaml file to resolve the error. or **alternatively directly update the object on cluster**

    - type the command: _**sudo kubectl edit pod test-pod**_ It opens object in vi editor.
 
      ![image](https://github.com/user-attachments/assets/3ef1f845-16b7-4430-9ac1-fb3ea08294b5)


    - Let's remove "s" highlighted in above image and **save** the pod object. It says "pod edited".
 
      ![image](https://github.com/user-attachments/assets/cf5b6f68-c116-494b-91fd-7879103ea7a7)


    - We don't have to use create / apply command again. Let's run the command _sudo kubectl get pods_ . It's **Ready** now
 
      ![image](https://github.com/user-attachments/assets/67fc0761-4acf-4f5e-a66b-c8c0338283c1)


  - **Now let's interact with pod**
    - type: _sudo kubectl exec -it test-pod -- sh_   
 
