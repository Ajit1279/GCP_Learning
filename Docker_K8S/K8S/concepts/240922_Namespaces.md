- Reference: https://www.youtube.com/watch?v=yVLXIydlU_0&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=11

- Basics:
  - Just provide one more level of isloation for your objects so that only authorised Ids / persons can manipulate those e.g. test, prod
  - Resources within the namespace are easily accessible by each other. For accessing resources in other namespaces FQDN is used
  - Kubernetes creates few namespaces
    - **Default:** By default objects are created in Default namespace if not specified
    - **Kube-System:** Kubernetes "system" components are created in this namespace
    - **kube-node-lease**
    - **kube-public**
    - **local-path-storage**
  - Type **sudo kubectl get ns** to display all namespaces    

-  
