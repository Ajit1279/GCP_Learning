- Reference: https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/
  
- **start minikibe** if not done already
  
- **Deploy an App:** kubectl create deployment my-gke-app --image=gcr.io/google-samples/kubernetes-bootcamp:v1
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ecc0c020-966f-4c08-a492-b40bf0d96b0c)

- Open a second terminal window to run a proxy:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/95e02851-d381-44e4-92fe-135f5aa06671)

- Expose your app using a service: kubectl expose deployment/my-gke-app --type="NodePort" --port 8080
 
- Run curl command in the first window: curl http://localhost:8001/version
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e09d728c-8f66-447a-8994-8971aa6880f9)

- **Update the version of the App**
  - To update the image of the application to version 2, use the set image subcommand, followed by the deployment name and the new image version:

  - kubectl set image deployments/my-gke-app kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/48593017-7881-401e-b1be-bb73a0283cbc)

  - Verify an update: kubectl describe services/my-gke-app
  
  - Create an environment variable called NODE_PORT that has the value of the Node port assigned:
    - export NODE_PORT="$(kubectl get services/my-gke-app -o go-template='{{(index .spec.ports 0).nodePort}}')"

    - echo "NODE_PORT=$NODE_PORT"
    
    - Next, do a curl to the exposed IP and port: curl http://"$(minikube ip):$NODE_PORT"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/419eb11c-618a-4dba-9344-fed668f36e57)

    - You can also confirm the update by running the rollout status subcommand: kubectl rollout status deployments/my-gke-app
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/49e89ea4-a015-4a3f-89ce-8206ff1ed982)

 
- **Rollback an update**

  - Run command: kubectl get pods Notice that some of the Pods have a status of ImagePullBackOff.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ceacbcda-b205-4771-a90e-b40110503a16)

  - To roll back the deployment to your last working version, use the rollout undo subcommand: kubectl rollout undo deployments/my-gke-app
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6796456e-12b6-443a-93ae-8480ff9b75b0)

  - Run command: kubectl describe pods | less
    The deployment is again using the stable version **kubernetes-bootcamp:v1**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/08b7de31-eae1-44eb-9f04-6fe06105c031)
  
