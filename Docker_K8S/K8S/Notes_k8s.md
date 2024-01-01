**Containerization** helps package software, enabling applications to be released and updated without downtime.

**Kubernetes** is a production-ready, open source platform for container orchestration
It helps you make sure those containerized applications run where and when you want, and helps them find the resources and tools they need to work.
In prod env you need to ensure there's no downtime. That's how **Kubernetes come to the rescue!** For example, if a container goes down, another container starts.

**Kubernetes Cluster** consists of:
 - **Control Plane:** Responsible for managing the cluster (scheduling applications, maintaining applications' desired state, scaling applications, and rolling out new updates.)
 -  **Nodes:**
    - A node is a VM or a physical computer that serves as a worker machine in a Kubernetes cluster.
    - A Kubernetes Node runs at least:
    	- **kubelet** - a process responsible for communication between the Kubernetes control plane and the Node; it manages the Pods and the containers running on a machine.
     - **A container run time (like Docker)** - responsible for pulling the container image from a registry, unpacking the container, and running the application.

**Cluster Overview**
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/623125d0-47fe-4316-ae2b-580ddc2d9e76)

**Node Overview**
	![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b41a0a6c-8873-4a38-992f-9699aec0067e)
 
   - **kubelet:** An agent within the node for managing it and communicating with kubernetes control plane using Kubernetes API.
   - **Containerd or CRI-O:** Tool within the node for handling container operations
   - **Min 3 nodes recommended in production to handle traffic and better redundancy**
   - **End users can also use the Kubernetes API directly to interact with the cluster.**


• **Architecture:**
   - **Hardware (Cluster):** highly available cluster of computers that are connected to work as a single unit.
     	- **Master Node:** Manage the cluster
     	- **Worker Node:** Run workloads (as pods)
     	- **Node Pool:** Group of nodes in cluster with same configuration e.g. ML mode pool using GPUs

   - **Software:**
   	-  **Deployments:**
       		- You can **create and manage a Deployment** by using the Kubernetes command line interface, **kubectl**.
       		- The Deployment **instructs Kubernetes how to create and update instances of your application.**.
       		- The **control plane schedules the application to run on individual Nodes** in the cluster.
     		- When you deploy applications on Kubernetes, you tell the control plane to **start the application containers**.
   		- **Manage pods** (you can not directly create pods)
		- Deployment is created for each microservice and represents all it's releases. It's imp role is **zero downtime deployments**.
     - **Deployment Controllers:**
       	- **Continuosuly monitor application instances.**
       	- **Achieve Self-Healing mechanism:** by replacing the instance with an instance on another Node in the cluster.
       	
     - **Pods:**
         - It's a **Smallest deployable unit** in Kubernetes. Pod represents a group of one or more application containers.
         - POD always run on a node. Kubernetes control plane automatically handles scheduling the pods across the Nodes in the cluster.
         - You can not deploy containers directly on Kubernetes.  **When you created deployment, Kubernetes created a Pod to host your application instance.**
         - **Run on private isolated network** and have shared storage (as volume), network (unique IP address), info about how to run each container (e.g. container image version or specific ports to use)
         - Visible from other pods and services within the **same Kubernetes cluster**	
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8874b0ab-64a4-4e40-976c-88a776ca38bd)

    		
     - **Service:**
         - Exposes the deployment to the outside world. Routes traffic across a set of Pods.
         - A service is defined using YAML or JSON, like all Kubernetes object manifests.
         - Services match a set of Pods using labels and selectors, a grouping primitive that allows logical operation on objects in Kubernetes.
         - Services can be exposed using four types:
       	    - Cluster IP (default): Use Case: Microservice only to be available inside cluster
            - NodePort: Exposes service on each node's IP at a static port (NodePort)  Use Case:  Create one Ingress NOT multiple Load Balancer
            - LoadBalancer:  Use Case: Individual load balancer for each microservice
            - ExternalName: Maps the Service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value. No proxying of any kind is set up.
            - Kubectl expose deployment name --type=LoadBalancer --port=80
            - kubectl get services
            - Labels are key/value pairs attached to objects:
               - Designate objects for development, test, and production
               - Embed version tags
               - Classify an object using tags
	     
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7a979e89-cc42-40d3-9080-bbd42252357d)

 
• **Scheduling:** Match PODs with Nodes so that kubelet can run them
• **Preemption:** Terminate pods with lower priority so that pods with higher priority can schedule on nodes
• **Eviction:** Proactively terminating one or more Pods on resource-starved Nodes.
   
• **Ingress:** Collections of rules for routing external HTTP(S) traffic to your number of services e.g. if enquiry-service go to port 8000, if contribution-service go to port 8100 etc.
	○ Provides Load Balancing, SSL Termination
	○ Expose each micro-service using NodePort service 

• **Replicasets:** Ensures specific number of pods are running for specific microservice version (kubectl get replicasets)

• 
	 
• **Container Registry:**
	○ Fully managed service to store docker images for your micro-services.   
	○ Alternative to Docker Hub
	○ Secure container images
	○ Analyze for vulnerabilities
	○ Enforce deployment policies
	○ Naming: HostName/ProjectID/Image:tag e.g. gcr.io/projectname/helloworld:1 

• Dockerfile:
	○ Contains Instructions to create docker images 
	○ 
	○ Best Practices:
		§ Use light weight images (Prefer Alpine images over Ubantu)
		§ Do not copy anything unnecessary
		§ Follow proper layering: Things that change less often (e.g. dependencies) on top and code changes (index.js) often.
			
	
• Scenarios:
	○ Cost Optimization: Preemptible VMs, appropriate region, committed user discount, Use E2 machine types, Use multiple node pools
	○ Efficient Auto-scaling:  Configure HPA, Cluster autoscaler
	○ Execute untrusted third-party code: New node pool with GKE sandbox and deploy untrusted code to it. 
	○ Only internal communication between microservice deployments: Create service of type ClusterIP
	○ Pod stays pending: Pod can not be scheduled onto a node (insufficient resources)
	○ Pod stays waiting: Failure to pull the image
	○ Pod becomes unhealthy which service will identify and replace the pod?: ReplicaSet   
	
• Deleting kubernetes resources (in given order):
	○ Delete service: kubectl
	○ Delete deployment:  kubectl
	○ Delete cluster : gcloud
	○ Delete project: gcloud 

• 
• C

===============================================================================
https://www.weave.works/blog/deploying-an-application-on-kubernetes-from-a-to-z

How to deploy an app on GKE:

Step 1: Dockerize The Application 

Step 2: Creating a Deployment
	The first step in moving to Kubernetes is to create a Pod that hosts the application container. But since pods are ephemeral by nature, we need to create a higher controller that takes care of our pod (restart if it crashes, move it around nodes, etc.). For that reason, we’ll use a Deployment. 

Step 3: Exposing Our Application Using Service and Ingress
	
Step 4: Handling Application Configuration Using ConfigMaps
	
Step 5: Securing Confidential Data Using Secrets
	
Step 6: Deploying the Backend Storage (Redis) Using a StatefulSet
	
Step 7: Adding HTML Content to the Application
	
Step 8: Packaging Our Kubernetes Cluster Using Helm

======================================================
Promethius: 
https://www.weave.works/blog/a-comprehensive-guide-to-prometheus-monitoring

==========================================================
GitOps Deployments from VS Code with little to no Kubernetes Knowledge:
https://www.weave.works/blog/gitops-deployments-from-vs-code

==========================================================


