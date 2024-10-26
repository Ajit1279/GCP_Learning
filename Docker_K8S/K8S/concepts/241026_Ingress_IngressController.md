- Reference: https://www.youtube.com/watch?v=kf3UjITS91M&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=35

- Basics:
  - Your application can be exposed to the customers as NodePort or Load Balancer.

  - Nodeport is accessible to organization internal customers only

  - LoadBalancer has some disadvantages like:
    -  It is dependent on cloud provider i.e. it may only support ALB, but not nginx, F5, Paulo-Alto, CISCO etc.
    -  It's costly
    -  Security is limited by what's provided by cloud provider
    -  The type of LB you want (e.g. ratio based) is not available, only default Round-Robin

  - Back in those days when K8S didn't exist, simple application deployed on VM could provide whitelisting / blacklisting, DDoS protection, Web Application Firewall etc. but these are not available in K8S. These issues are addressed by Ingress

  - **Ingress:** Traditional approach doesn't work because your application may add / remove pods, you may have new services. So we'll write the Ingress specifications in YAML

  - **Ingress Controller:** Ingress Controller is written by comanies providing it (e.g. CISCO, Nginx etc.), we just need to deploy those. Ingress Controller reads this YAML. 

  - **Load Balancer:** Load Balancer is created by Ingress Controller according to the configuration (YAML)

  - So the steps are:
    - Create an Ingress Controller
    - Create an Ingress, which will be monitored by Ingress Controller
    - Load Balancer is created according to the configuration (metadata.annotation and spec in YAML)

  - Please note Ingress Controller is never a Load Balancer.

  - **IngressClassName** is important which is matching criteria for Ingress Controller to watch the Ingress

---------------------------------------------- 
