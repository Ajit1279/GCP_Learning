- Reference: https://www.youtube.com/watch?v=eVtnevr3Rao&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=27

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
    - **Please start set-up from 33:00**. Please use Calico
    - 
    -  
