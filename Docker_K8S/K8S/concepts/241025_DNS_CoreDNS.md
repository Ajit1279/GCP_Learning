- Reference: https://www.youtube.com/watch?v=fDOoB4k4YSs&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=31

  

-----------------------------------------------------
- **CoreDNS in K8S**
  - Reference:  https://www.youtube.com/watch?v=VcWpZoRAQXE&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=32
  - Reference: https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
    
  - K8S deploys a pod with the name **CoreDNS as Deployment**. This deployment is exposed as **"kube-dns" service** in K8S. (Just to recall, **Deployment manages** the **state of a pod** by launching it, ensuring the desired number of replicas are running, and replacing unhealthy pods. **Service Exposes** an interface to pods, **enabling network access** from within the cluster or between external processes and the service.) 

  - Like DNS over internet, it provides service to resolve domain name with IP Address within the K8S cluster.

  - If one ssh into the pod and go to /etc/resolve.conf file, it'll show the details used for routing like high level domain (cluster.local) and subdomains (svc.cluster.local, default.svc.cluster.local) 

  - There's also /etc/hosts file which contains IPs of all pods

  - If we "describe" on of the core DNS Pods, it shows mounts: /etc/coredns: a configmap attached to a volume, which contains few plugins like health-probe, top level domain, load-balancing etc

  - First step for troubleshooting should always be checking the network set-up (e.g. Calico etc. is set-up or not)   
