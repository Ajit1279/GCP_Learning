- Reference:
  - https://www.youtube.com/watch?v=eVtnevr3Rao&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=27
  - https://docs.tigera.io/calico/latest/getting-started/kubernetes/kind 

- Basics:
  - various resources within the cluster can communicate with each other using **CNI (Container Network Interface)**
  - There various CNI providers/plugins like weave-net, flannel, calico, cilium, kindnet as shown in the diagram
  - CNI creates a pod (say e.g. weave-net) in each node deployed as a deamonset
  - If we **intend front-end not to interact with database / storage layer directly**, we'll need to restrict that connection. This is where **network policies** come into picture
  - **Not all CNI plugins enforce Network policies e.g. flannel, kindnet**
  - To **disble "default" network policies**, we will need to **add networking.disableDefaultCNI = true**
  - The policies can be created by specifying certain criteria (e.g. matching labels)
  - We'll observe the following in the demo
    - Allow all connections i.e. Frontend to Backend, Frontend to DB, Backend to DB
 
      ![image](https://github.com/user-attachments/assets/eddfc5f4-8f8f-403f-bae2-5e871cec61b5)

    - Allow Backend to DB connection only

      ![image](https://github.com/user-attachments/assets/33210dff-37e0-48cb-ae23-8f22e5b2603c)


  ------------------------------------
  - Demo
    - **Please start set-up from 33:00**. The [Weavenet CNI](https://github.com/weaveworks/weave) used for the demo was out of date.
    - **Please use Calico** instead as it's also used as default by most of the cloud providers as well.

    - Type commands. As observed kindnet is installed by default

            sudo kubectl get pods -A
            sudo kubectl get ds -A

        ![image](https://github.com/user-attachments/assets/469f7ed0-b0b6-4f0d-a96a-50a2b375f429)

    - Create [calicokind.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/calicokind.yaml) to disable the default CNI to use Calico CNI.
      - podSubnet is added so that it does not clash with your existing subnet range
      - extraPortMappings are also added to enable port 30001  
      - Run the below command:

           sudo kind create cluster --config calicokind.yaml --name nwpol
    - 
