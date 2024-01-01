Reference: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

**1. Namespaces:**
- Mechanism for **isolating groups of resources** within a single cluster (divide cluster resources between multiple users)
- Intended for use in environments with **many users spread across multiple teams**, or projects 
- Each Kubernetes **resource can only be in one namespace.**
- Names of resources need to be **unique within a namespace**, but not across namespaces.
- Namespace-based **scoping is applicable only for namespaced objects (e.g. Deployments, Services, etc)** and not for cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes, etc).
- For a **production** cluster, consider **NOT using the default namespace**. Instead, make other namespaces and use those.
- When you create a Service, it creates a corresponding DNS entry. This entry is of the form <service-name>.<namespace-name>.svc.cluster.local, which means that if a container only uses <service-name>, it will resolve to the service which is local to a namespace.
- If you want to reach across namespaces, you need to use the fully qualified domain name (FQDN).

**2. Initial Namespaces**
- If you type _kubectl get namespace_ it will display 4 system created namespaces.
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d4362193-ed84-4c33-a184-c4e6c5fa1f35)

- **Default:** - Kubernetes includes this namespace so that you can start using your new cluster without first creating a namespace.
- **kube-node-lease** - to send heartbeats so that the control plane can detect node failure.
- **kube-system** - The namespace for objects created by the Kubernetes system
- **kube-public** - Reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster.


**3. Namespace operations:**
- **1. Create a namespace:**:
        i). kubectl create namespace my-first-namespace
       ii). Create a file named my-namespace.yaml (https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/my-namespace.yaml)
           Run command: kubectl create -f ./my-namespace.yaml
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/355b1a71-9242-45b8-81c1-5dc21e88ef42)

        
**4. Namespace-based scoping is applicable only for namespaced objects (e.g. Deployments, Services, etc) and not for cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes, etc).**
- **i). Let's create a development and production namespace**
  kubectl create -f https://k8s.io/examples/admin/namespace-dev.json
  kubectl create -f https://k8s.io/examples/admin/namespace-prod.json
  
- **ii) Create pods in each namespace:**
  kubectl create deployment snowflake \
  --image=registry.k8s.io/serve_hostname \
  -n=development --replicas=2
  
- **iii) Run the commands:** kubectl get deployment -n=development; kubectl get pods -l app=snowflake -n=development
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b4ffe091-d050-457c-88ee-14daeebc4249)

- **iv) Let's create some cattle pods in production:**
        kubectl create deployment cattle --image=registry.k8s.io/serve_hostname -n=production

        kubectl scale deployment cattle --replicas=5 -n=production

        kubectl get deployment -n=production

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ea6e9fee-cd20-4a69-bb37-e632e888b609)

        kubectl get pods -l app=cattle -n=production
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/26b65e6a-108a-44f3-83d5-9250196d54fa)

It's evident from the above screenshots that the resources users create in one namespace are hidden from the other namespace.

