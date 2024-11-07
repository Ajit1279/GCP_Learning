- Reference: https://www.youtube.com/watch?v=Q-mk6EZVX_Q&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=17

- Basics:
  - The pods will be scheduled if sufficient resources available on a node, or it'll encounter an error "insufficient resources"

    ![image](https://github.com/user-attachments/assets/0e341aa7-183c-46cc-a9c1-45c0fc6555f4)

  - Say the pod is scheduled already, but starts consuming all the resources in a node, then node will crash with an error "Out of Memory"

      ![image](https://github.com/user-attachments/assets/d680cbe9-81e0-444b-a195-9be2de89b719)

  - Resources and Limits avoids above situation and pod crashes rather than entire node.

    ![image](https://github.com/user-attachments/assets/741badc3-b5c7-481f-a70b-472445487c00)

-------------------------------------------------
- Demo
  - Create a [metrics-server](https://github.com/piyushsachdeva/CKA-2024/blob/main/Resources/Day16/metrics-server.yaml) yaml. It extracts matrix from nodes and utlise in other processes.

  - Type command: **sudo kubectl apply -f metrics-server.yaml**

     ![image](https://github.com/user-attachments/assets/230235a6-92fe-4efe-9592-42ee0e0f629e)

  - **sudo kubectl get pods -n kube-system** displays there's a pod running with **metrics-server-67fc4df55-9tft8**

     ![image](https://github.com/user-attachments/assets/5462438c-d532-4b86-8002-b0742497cacf)

  - **sudo kubectl top node** displays the CPU, Memory utilization

     ![image](https://github.com/user-attachments/assets/0d49b77e-2919-404b-8a85-665440449072)

  - Let's create namespace memory-example

     ![image](https://github.com/user-attachments/assets/86c8d40f-6715-44c7-8bd6-350268f38b41)

  - Create [mem-request.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/mem-request.yaml) by referring [documentation](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/#specify-a-memory-request-and-a-memory-limit)
    - image (polinux/stress) was built to do the stress testing of the cluster
    - resources requests (100 Mi) and limits (200 Mi) for memory are specified. Mi is different unit
    - command: Stress for stress testing
    - args: We are assigning 150 MB pod (more than request but within limits)  

     ![image](https://github.com/user-attachments/assets/42bd6349-e7b6-432d-8d5e-6f737e643770)

  - Run command: **sudo kubectl get pods -n memory-example**

     ![image](https://github.com/user-attachments/assets/72dcbee6-5b0b-4a0c-b383-f4149964150b)

  - **sudo kubectl top pod -n memory-example**

     ![image](https://github.com/user-attachments/assets/7ae67a10-0251-4d7d-b9a5-5c178ab2910a)

  - Now let's assign more memory than limit (say 250 MB). Please refer [mem-request1.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/mem-request1.yaml)

  - Run command: **sudo kubectl apply -f mem-request1.yaml**

    ![image](https://github.com/user-attachments/assets/9f479ef4-4416-499c-ae8f-cf5bb3ef6f9b)

  - Type **sudo kubectl get pods -n memory-example**

    ![image](https://github.com/user-attachments/assets/6c4ff596-60a9-4bdc-8018-b21d593b7b2a)

  - **sudo kubectl describe pod memory-demo-2 -n memory-example | less**

     ![image](https://github.com/user-attachments/assets/7b46dd77-ef85-4636-b20b-9986fc4e6524)
    

     ![image](https://github.com/user-attachments/assets/c9947900-da1c-4f9d-99eb-aaae58a979ab)

  - The command **sudo kubectl top pod memory-demo-2 -n memory-example** returns error as pod was not created

      ![image](https://github.com/user-attachments/assets/9d2f468b-3e36-49e2-b8b0-4b8d8e3b3e84)

  - Let's create one more yaml with memory way more than that's available within node ([mem-request2.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/mem-request2.yaml))      

  - Run command: **sudo kubectl apply -f mem-request2.yaml**

      ![image](https://github.com/user-attachments/assets/1d974b86-bfbf-461a-8fa8-71915012ed16)

  - Type **sudo kubectl get pods -n memory-example**. Note that pod is in pending state.

      ![image](https://github.com/user-attachments/assets/aa9188c0-641e-4cc0-b34f-c6b63b3166fc)

  - **sudo kubectl describe pod memory-demo-3 -n memory-example | less** (**Note the error message: 3 Insufficient memory. preemption: 0/4 nodes are available: 1 Preemption is not helpful for scheduling, 3 No preemption victims found for incoming pod..**)

      ![image](https://github.com/user-attachments/assets/94e3d8f3-d4d2-44f0-9570-28f348db592a)

