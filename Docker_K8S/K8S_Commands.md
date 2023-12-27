**kubeadm** - Tool to create and manage Kubernetes clusters. kubeadm doesn't install kubectl or minikube automatically. Appropriate version need to be installed 
to avoid buggy performance.

**Kubectl** - Command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API
**kubectl** looks for a file named config in the $HOME/.kube directory. You can specify other kubeconfig files by setting the KUBECONFIG environment variable or 
  by setting the --kubeconfig flag.

**minikube** runs an all-in-one or a multi-node local Kubernetes cluster on your personal computer (including Windows, macOS and Linux PCs) so that you can try out
Kubernetes or for daily development work.

Test to ensure the **version you installed is up-to-date** Or use this for detailed view of version: *kubectl version --client --output=yaml*
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f58608f2-4e8b-4808-b34e-f43c10169595)

Check that **kubectl is properly configured** by getting the cluster state: *kubectl cluster-info*
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b70fdff7-4107-4fa7-ad0b-11d932dbdadb)

**Enable auto-completion for BASH**: *kubectl completion bash* You can also install it with *apt-get install bash-completion* or *yum install bash-completion*

==================================================================================================================================================

**Pod** - Group of one or more Containers, tied together for the purposes of administration and networking. The Pod in this tutorial has only one
Container. 

**Kubernetes Deployment** checks on the health of your Pod and restarts the Pod's Container if it terminates. Deployments are the recommended way to manage
the creation and scaling of Pods.

==================================================================================================================================================

**Basic Minikube commands:** https://kubernetes.io/docs/tutorials/hello-minikube/ 

   i. **Create a minikube cluster:** minikube start
  
  ii. **Run a test container image that includes a webserver:** kubectl create deployment hello-node --image=registry.k8s.io/e2e-test-images/agnhost:2.39 -- /agnhost netexec --http-port=8080
  
  iii. **View the deployments:** kubectl get deployments
  
  iv. **view the pods**: kubectl get pods
  
  v. **View the services you created** : kubectl get services
  
  vi. **clean up the resources you created in your cluster:** kubectl delete service hello-node, kubectl delete deployment hello-node
  
  vii. **Stop the Minikube cluster:** minikube stop
  
  viii. **Optionally, delete the Minikube VM (only if you don't want to use it again for learning K8S):** minikube delete

ds
ds
ds
ds
ds
ds
ds
ds
d
sd
sd
sd
sd
sd
sd
s
ds
ds
d
sd
sd
sd
sd
sd
sd
sd
sd
sd
s
ds
ds
ds
d
sd
sd
sdsd
ds
d
