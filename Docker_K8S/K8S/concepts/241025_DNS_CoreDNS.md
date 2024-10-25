- Reference: https://www.youtube.com/watch?v=fDOoB4k4YSs&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=31

-----------------------------------------------------
- **CoreDNS in K8S**
  - Reference:  https://www.youtube.com/watch?v=VcWpZoRAQXE&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=32
  - K8S deploys a pod with the name **CoreDNS as Deployment**. This deployment is exposed as **"kube-dns" service** in K8S. (Just to recall, **Deployment manages** the **state of a pod** by launching it, ensuring the desired number of replicas are running, and replacing unhealthy pods. **Service Exposes** an interface to pods, **enabling network access** from within the cluster or between external processes and the service.) 
  - Like DNS over internet, it provides service to resolve domain name with IP Address within the K8S cluster.
  -  
