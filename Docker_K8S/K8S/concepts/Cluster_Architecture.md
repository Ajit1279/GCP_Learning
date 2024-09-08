1. **Reference:** https://kubernetes.io/docs/concepts/architecture/
   
2. The diagram depecting **architecture:**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2eeab5fe-3cc3-48dd-ac9c-5b7fb4a6ebde)

Run below commands in cloudshell: '

kubectl get namespaces:

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ee256e6b-eb88-42d1-bc24-b7a8c8829b2a)

kubectl get pods --namespace=kube-system:

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1320178f-abb2-4dfd-aebd-b6f630f24c9d)

3. **Nodes**
   - Two Nodes cannot have the same name at the same time. Kubernetes also assumes that a resource with the same name is the same object.
     
   - Kubernetes checks that a kubelet has registered to the API server that matches the **metadata.name** field of the Node. If the node is healthy (i.e. all necessary services are running), then it is eligible to run a Pod. Otherwise, that node is ignored for any cluster activity until it becomes healthy.
     
   - It may lead to inconsistencies if an instance was modified without changing its name. If the Node needs to be replaced or updated significantly, the existing Node object needs to be removed from API server first and re-added after the update. 
   
   - The kubelet on node self registers to control-plane (https://kubernetes.io/docs/concepts/architecture/nodes/#self-registration-of-nodes)
     kubectl get nodes
     
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/224dc9ca-d92f-4ad4-b16d-3c867e6979c2)
  
   - Manual Node Administration using JSON manifest files (https://kubernetes.io/docs/concepts/architecture/nodes/#manual-node-administration)
      -  Create Node Manifest JSON file (e.g. [nodemanifest.json](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/nodemanifest.JSON))
      -  
   - 
     

5. 


 
