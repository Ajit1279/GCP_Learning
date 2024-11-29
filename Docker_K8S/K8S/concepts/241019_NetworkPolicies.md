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

    - Create a VM instance, install kind, docker and kubect. **Please DO NOT create cluster yet**

    - Create [calicokind.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/calicokind.yaml) to disable the default CNI to use Calico CNI.
      - podSubnet is added so that it does not clash with your existing subnet range
      - extraPortMappings are also added to enable port 30001  
      - Run the below command:

           sudo kind create cluster --config calicokind.yaml --name nwpol

    - Confirm that you now have three nodes in your cluster

           sudo kubectl get nodes -o wide

         ![image](https://github.com/user-attachments/assets/6657e0a5-711b-4ea4-9872-f9629929673f)

      
    - Install Calico

          sudo kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/calico.yaml
      
    - Verify Calico installation:

          sudo kubectl get pods -l k8s-app=calico-node -A

        ![image](https://github.com/user-attachments/assets/ec572209-1894-4774-871a-462fa77e0f62)

    - Create [appmanifest.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/appmanifest.yaml) and apply it

          sudo kubectl apply -f appmanifest.yaml

        ![image](https://github.com/user-attachments/assets/ba33249d-64e5-413b-9080-0ec4c15b2052)

    
    - Let's check if the pods are running and exec into the frontend pod

          sudo kubectl get pods
          sudo kubectl exec -it frontend -- bash

        ![image](https://github.com/user-attachments/assets/f0850829-9d18-4a4a-86b2-d3247b9a76c9)

    - We'll check if we are able to reach backend from frontend. Curl to the backend using port 80, as backend is a service we can refer it by hotname and got a successful response back.

          curl backend:80

        ![image](https://github.com/user-attachments/assets/47661efa-59bd-4890-8c60-20a293e6f1e3)

    - We'll check if we are able to reach from frontend to DB. We can not curl to DB as it does not have any end-point. So let's install telnet on it. Telnet from frontend to db is not working

          apt-get update && apt-get install telnet -y
          telnet db 3306

        ![image](https://github.com/user-attachments/assets/df701761-a05b-4410-9775-09d75cdd30e8)


    - Let's exec into backend and install telnet on it and telnet to db

          sudo kubectl exec -it backend -- bash
          apt-get update && apt-get install telnet -y
          telnet db 3306

        ![image](https://github.com/user-attachments/assets/51441b4a-50d6-49ac-ad99-72ccf5189bdc)

    - Let's see if curl to frontend works

          curl frontend:80

        ![image](https://github.com/user-attachments/assets/97b51d2d-a013-419e-bee2-12cf281a8a99)

    - Now let's see if we create a network policy to allow frontend to db access works. Create [netpolicy.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/netpolicy.yaml) and apply it

          sudo kubectl apply -f netpolicy

        ![image](https://github.com/user-attachments/assets/d1e388cd-5a00-4ff5-8d0d-cc90fdcc9989)


    - Describe the new network policy

          sudo kubectl describe netpol db-test

        ![image](https://github.com/user-attachments/assets/5728c56b-9f57-4763-a59b-b996f87a5428)

    - Let's exec into frontend again and telnet to db

            sudo kubectl exec -it frontend -- bash
            telnet db 3306

        ![image](https://github.com/user-attachments/assets/9c5e1b23-cd60-413a-9b3c-530ba7e65947)

    - Let's exec into backend and telnet to db. As observed, the connection is NOT working

            sudo kubectl exec -it backend -- bash
            telnet db 3306

        ![image](https://github.com/user-attachments/assets/7def7c79-a248-47bb-b066-4b89d1bafdb2)

    - Revert the netpolicy to allow traffic from backend to db only not through frontend (change role: frontend to role:backend)
        
