- References: https://www.youtube.com/watch?v=5vimzBRnoDk&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=16

- **Basics:**
  - **Taints & tolerations only restricts node from accepting certain types of pods, but the pod may get scheduled on any other node which doesn't have taint**.
    
  - **Node Affinity** matches the **affinity sets on pods** to that with the nodes to schedule a pod on it. **Unlike taints & tolerations, we can specify multiple conditions.**

  - Node Affinity and Taints & Tolerations are used in combination.  

  - If the **labels from node are removed**, the **existing pod remains scheduled** there, but **new pods with similar affinity won't be scheduled**    
    
      ![image](https://github.com/user-attachments/assets/b4d50482-b939-49b4-9e16-86ae278c4020)

  - There are **two** important properties for **Node Affinity**
    - **requiredDuringSchedulingIgnoredDuringExecution**: **Schedule a pod** on node **only if** the **operator on the node is matching**, so the **pod may stuck in pending state**
    - **preferredDuringSchedulingIgnoredDuringExecution**: **Schedule a pod** on node **even if** the **operator on the node is NOT matching**
    - The **last part is same** indicating the properties **do not impact existing pods, only to new pods**

  - **To summarise**
    - **Node selector: Simpler and more primitive mechanism without much fine-grained control to specify which nodes a pod should be scheduled on based on node labels**  
    - **Use combination of Taints & Tolerations and Node Affinity rules together** to completely dedicate nodes for specific pods.
    - **Taint should be used when you want to mark a node as unavailable for certain pods**. For example, you can use taint to mark a node as "maintenance" and prevent pods from being scheduled on the node while it is undergoing maintenance. (**Office access is restricted to it's staff only**)
    - **Affinity:**
      - **Node affinity : Which nodes a pod should or should not be scheduled based on node labels** (**Washroom for male/ female or server room access restricted to certain staff only**)
        - **Provides more fine-grained control over pod scheduling** compared to node selector
        - **Allows you to specify complex rules for pod scheduling** based on multiple node labels.
      - **Pod affinity: Use when you want to specify which nodes a pod should or should not be scheduled with based on labels** e.g. to co-locate or separate certain pods from each other (**e.g. all the teams in a particular department are allowed to enter on say Level1 of the office, but only Team A members are allowed to use Room1, Team B members are allowed to use Room2 and so on..... but Cafeteria is open to all etc.**) 
--------------------------------------------------------------------------
      
  - **requiredDuringScheduling Demo**
    - [Create a compute engine instance and create kind cluster on it.](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md)

    - Create [afinity.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/afinity.yaml) by referring [documentation](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/#schedule-a-pod-using-required-node-affinity)
      - It contains nodeAffinity within spec.affinity
      - Then one of the node affinity properties (requiredDuringSchedulingIgnoredDuringExecution)
      - Then expressions to be matched (key value pair)

    - Type command: **sudo kubectl get nodes --show-labels**. As observed, there are no matching labels.
 
      ![image](https://github.com/user-attachments/assets/1448eb2e-e509-4277-9c60-f30753042089)

    - Run the command: **sudo kubectl apply -f afinity.yaml**
 
      ![image](https://github.com/user-attachments/assets/efc36f29-9d5d-42dc-b12c-ff7dd2d5925d)

    - Run command: **sudo kubectl get pods**. Please note that the pod is in pending state
 
      ![image](https://github.com/user-attachments/assets/776b0773-bfa5-4a30-8a66-ac55b2794050)

    - Run the command: **sudo kubectl describe pods nginx**. Please note the message: **3 node(s) didn't match Pod's node affinity/selector.**
 
      ![image](https://github.com/user-attachments/assets/28b00e07-4267-44f5-b81d-a71cccf17148)

    - Now type: **sudo kubectl get nodes** and then **sudo kubectl label node kind-worker3 disktype=ssd**  and then **sudo kubectl get nodes --show-labels**
 
      ![image](https://github.com/user-attachments/assets/f5c31e52-27e7-4bb1-b087-eaa788e7a44b)

    - Now type **sudo kubectl get pods**, the pod is in running status
 
      ![image](https://github.com/user-attachments/assets/8af0de4e-3713-43fe-a34d-68a0f71ba2ed)

    - Type: **sudo kubectl describe pod nginx**
 
       ![image](https://github.com/user-attachments/assets/48f4c4d4-4ecf-4b5c-b81a-689a07061e81)

  - **preferredDuringScheduling Demo**
    - The pod is scheduled even though the labels not matching
    - The pod will continue to run even if the label is removed
    - There are multiple operators like In, Exists (the label should exist, may not be matching) 

