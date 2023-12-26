
	• Architecture:
		○ Hardware (Cluster):
			§ Master Node: Manage the cluster
			§ Worker Node: Run workloads (as pods)
			§ Node Pool: Group of nodes in cluster with same configuration e.g. ML mode pool using GPUs
		○ Software:
			§ Pods: Smallest deployable unit in Kubernetes. (You can not deploy containers directly on Kubernetes)
			§ Deployments: 
				□ Manage pods (you can not directly create pods)
				□ Deployment is created for each microservice and represents all it's releases. It's imp role is zero downtime deployments. 
			§ Service: 
				□ Exposes the deployment to the outside world. It is set of pods with a network endpoint
				□ Three types: 
					® LoadBalancer:  Use Case: Individual load balancer for each microservice
					® Cluster IP: Use Case: Microservice only to be available inside cluster
					® NodePort: Exposes service on each node's IP at a static port (NodePort)   Use Case:  Create one Ingress NOT multiple Load Balancer
				□ Kubectl expose deployment name --type=LoadBalancer --port=80
				□ kubectl get services
 
	• *Scheduling:* Match PODs with Nodes so that kubelet can run them
 	• *Preemption:* Terminate pods with lower priority so that pods with higher priority can schedule on nodes
  	• *Eviction:* Proactively terminating one or more Pods on resource-starved Nodes.
   
	• Ingress: Collections of rules for routing external HTTP(S) traffic to your number of services e.g. if enquiry-service go to port 8000, if contribution-service go to port 8100 etc.
		○ Provides Load Balancing, SSL Termination
		○ Expose each micro-service using NodePort service 

	• Replicasets: Ensures specific number of pods are running for specific microservice version (kubectl get replicasets)

	• 
	 
	• Container Registry: 
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


