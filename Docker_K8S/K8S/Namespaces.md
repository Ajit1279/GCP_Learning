Reference: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

**Namespaces:**
- Mechanism for **isolating groups of resources** within a single cluster (divide cluster resources between multiple users)
- Intended for use in environments with **many users spread across multiple teams**, or projects 
- Each Kubernetes **resource can only be in one namespace.**
- Names of resources need to be **unique within a namespace**, but not across namespaces.
- Namespace-based **scoping is applicable only for namespaced objects (e.g. Deployments, Services, etc)** and not for cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes, etc).
- For a **production** cluster, consider **NOT using the default namespace**. Instead, make other namespaces and use those.

**Initial Namespaces**
- If you type _kubectl get namespace_ it will display 4 system created namespaces.
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d4362193-ed84-4c33-a184-c4e6c5fa1f35)

- **Default:** - Kubernetes includes this namespace so that you can start using your new cluster without first creating a namespace.
- **kube-node-lease** - to send heartbeats so that the control plane can detect node failure.
- **kube-system** - The namespace for objects created by the Kubernetes system
- **kube-public** - Reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster.




