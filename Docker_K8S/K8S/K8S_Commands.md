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

==============================================================

**Pod** - Group of one or more Containers, tied together for the purposes of administration and networking. The Pod in this tutorial has only one
Container. 

**Kubernetes Deployment** checks on the health of your Pod and restarts the Pod's Container if it terminates. Deployments are the recommended way to manage
the creation and scaling of Pods.

=============================================================

**Basic Minikube commands:** https://kubernetes.io/docs/tutorials/hello-minikube/ 
  **Minikube is a lightweight Kubernetes implementation** that creates a VM on your local machine and deploys a simple cluster containing only one node.

   i. **Create a minikube cluster:** minikube start
  
  ii. **Stop the Minikube cluster:** minikube stop
  
  iii. **Optionally, delete the Minikube VM (only if you don't want to use it again for learning K8S):** minikube delete

=================================================================================

**Deployment:** 
[https://kubernetes.io/docs/tutorials/hello-minikube/](https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/) 

   i. **Create a Deployment** - by **specifying the container image for your application** and the **number of replicas** that you want to run. 
  
  ii. If you need to change any of these, just **update the deployment**
  
  iii. **Check kubectl is configured to talk to your cluster:** kubectl version 

  iv. **Deploy an app**: kubectl create deployment hello-node --image=registry.k8s.io/e2e-test-images/agnhost:2.39 -- /agnhost netexec --http-port=8080
                         kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
  
  iii. **View the deployments:** kubectl get deployments
  
  iv. **view the pods**: kubectl get pods
  
  v. **View the services you created** : kubectl get services

  vi. **Access the deployed app**

   **a.Using a proxy**      
          **□ Create a proxy in new terminal window that will forward communications into the cluster-wide, private network.** kubectl proxy 
          **Window2 screenshot**
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6210089f-7c94-4ebc-9980-5da796eed79f)

   **Window1 screenshot**
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/eb59457b-789e-4542-97ae-8f9e9b442038)

          □ If we stop the proxy using CTRL+C, you will not be able to access the app
   **Window2 screenshot**
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/956da003-9b7b-461f-b662-a81e08e1b79a)

   **Window1 screenshot**
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c77b1517-9777-46b2-a96c-a70e2456e05b)

   **b.using pod name**
          □ The API server will automatically **create an endpoint for each pod**, based on the pod name, that is also accessible through the proxy.
          
          □ Get the pod name and store it in environment variable called POD_NAME
          export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
          I hardcodes instead of above command: export POD_NAME=hello-minikube-7f54cff968-mcm2q

          □ echo Name of the Pod: $POD_NAME
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/18cab2a5-9535-41b0-922a-798202e51312)
          
          □ Access the Pod through the proxied API, by running: curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME:8080/proxy/
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/17b304e0-ff29-4878-9d72-65c21553dd07)

           □ View the container logs: kubectl logs "$POD_NAME"
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/bcf02c69-7e76-4808-a1d5-71e8b0c306e7)

  

  **c.Using service**
  
        □ Let's expose our application now using a Service and apply some labels.
          
        □ Let’s verify that our application is running: kubectl get pods

        □ Let’s list the current Services from our cluster: kubectl get services
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8a0f79ec-182a-45d9-a33d-83e240907507)

        □ **kubernetes** service is created by default when minikube starts the cluster. To create a new service and expose it to external traffic we'll use the expose command with NodePort as parameter
          kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/43cdfffc-e86f-4a3f-be4d-cf2a6b1559fc)

        □ To find out what port was opened externally (for the type: NodePort Service) we’ll run the describe service subcommand: kubectl describe services/kubernetes-bootcamp
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/15b72a35-38c5-4e86-a538-bed248b885a0)

        □ Create an environment variable called NODE_PORT that has the value of the Node port assigned:
              export NODE_PORT="$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')"
              echo "NODE_PORT=$NODE_PORT"
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/da56d68b-99fd-46bd-9db3-19bb343da282)

        □  Now we can test that the app is exposed outside of the cluster using curl, the IP address of the Node and the externally exposed port:
            curl http://"$(minikube ip):$NODE_PORT"
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/bd9ec268-6ed1-44ae-82c8-100ff2607bc5)

        □  Now let's use labels. The Deployment created automatically a label for our Pod. Find that using _kubectl describe deployment_.
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e53bd9f6-6ed4-4cf8-9035-cba8bea53f27)

        □  List the existing Services: kubectl get services -l app=kubernetes-bootcamp
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0ced35f6-fa49-4579-b428-e9bb79c0c593)

        □  To apply a new label we use the label subcommand followed by the object type, object name and the new label: kubectl label pods "$POD_NAME" version=v1

        □  We see here that the label is attached now to our Pod. And we can query now the list of pods using the new label: kubectl get pods -l version=v1
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/813a9a7d-9ef5-4411-b4fc-d2f7b0d65ceb)

        □  Now let's delete a service: kubectl delete service -l app=kubernetes-bootcamp   
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8b3cae98-f492-4fd6-9792-8988955573df)

        □  Confirm that the Service is gone: kubectl get services
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8f2ffe99-b0f3-4076-98a8-b2a68e4bb385)

        □  To confirm that route is not exposed anymore you can curl the previously exposed IP and port: curl http://"$(minikube ip):$NODE_PORT" 
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1048f78e-8803-4cb6-9be0-b8f0e4edf6db)

===========================================================================================

  **scaling the app**
  
        □  Scaling out a Deployment will ensure new Pods are created and scheduled to Nodes. 
  
        □  K8S supports auto-scaling (increase the number of Pods to the new desired state.) and scaling to zero pods.  
        
        □  list your deployments and pods: kubectl get deployments; kubectl get pods. It shows only one pod. 
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/61e269bc-1e05-4f7c-b490-8d9487362e20)
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a869772b-df37-4b4f-9ed2-929861cf0e9a)

        
        □  To see the ReplicaSet created by the Deployment, run:kubectl get rs
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/aa9c2d6f-de97-4b26-add7-242687f64aa7)

        □  DESIRED and CURRENT displays how many replicas have been defined and how many are running currently. 
        
        □  Let’s scale the Deployment to 4 replicas: kubectl scale deployments/kubernetes-bootcamp --replicas=4
           kubectl get pods -o wide displays
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7bb41b24-15c4-4409-b5ee-63a8294a99c3)

        □  Run the commands to create a node port: export NODE_PORT="$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')"
        echo NODE_PORT=$NODE_PORT

        □  Execute this command multiple times to observe that we hit a different pod with every request and load balancing is working
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5f3f6d0c-57cc-4fa4-8882-a41aeb90d321)

        □  To scale down to 2 replicas, run the scale command again: kubectl scale deployments/kubernetes-bootcamp --replicas=2 
           It is terminating two pods as shown below:
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/204b770a-4dd1-4263-b50f-d761cd99142e)

          and eventually only two pods:
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/df298069-7520-4dbf-b418-726c431b8d37)


  =========================================================================

  **Perform a Rolling Update**

    □  **Rolling updates** allow Deployments' update to take place with **zero downtime**
    
    □  By default, the **maximum number of Pods that can be unavailable** during the update and the maximum number of new Pods that can be **created**, is **one**.
    
    □  Can be **configured** to either **numbers** or **percentages (of Pods).**
    
    □  **Updates are versioned** and any Deployment update can be **reverted to a previous (stable) version.**
    
    □  Given below are the steps:
        i) To view the current image version of the app, run the describe pods subcommand and look for the Image field: kubectl describe pods | grep kubernetes-bootcamp | grep Image
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/af9552ad-8dc1-4a03-8c58-0a74b9c5650f)

       ii) To update the image of the application to version 2, use the **set image** subcommand, followed by the deployment name and the new image version: 
            kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/af63f074-6763-4d1a-9165-efacec097c1f)

      iii) Please note the new pods: 
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f5d2aa82-19df-452b-8a27-308b07a47cce)

       iv) Now let's verify the updates:  You will hit a different Pod every time. 
          export NODE_PORT="$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')"
          echo "NODE_PORT=$NODE_PORT"
          curl http://"$(minikube ip):$NODE_PORT"
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/94908662-6555-4c95-a5c1-26ec46a07e90)


       v) To view the rollout status: kubectl **rollout status** deployments/kubernetes-bootcamp 
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/dc72a87a-3750-4774-9a60-a08d0114a35b)

      vi) View the current image of the version: kubectl describe pods | grep bootcamp
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5d9c1dc7-12e4-47c3-be28-6401de174af7)

     vii) To roll back the deployment to your last working version, use the **rollout undo** subcommand: kubectl rollout undo deployments/kubernetes-bootcamp 
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/faec368c-c800-488e-b721-f4ae3074289f)


===========================================================================================
  Trobleshooting with kubectl:
  
   **kubectl get** - list resources
   **kubectl describe** - show detailed information about a resource
   **kubectl logs** - print the logs from a container in a pod
   **kubectl exec** - execute a command on a container in a pod
  
  ix. **clean up the resources you created in your cluster:** kubectl delete service hello-node, kubectl delete deployment hello-node

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
