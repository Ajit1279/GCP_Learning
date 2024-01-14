https://kubernetes.io/docs/tutorials/hello-minikube/

- Run: minikube start
  
- Open the dashboard: minikube dashboard
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8e05a8ba-3647-4a2c-87b5-f8bbb17c9520)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0ccb8fe5-1721-43d1-a6da-1dee617662a1)

- Create a deployment: kubectl create deployment mydeployment --image=registry.k8s.io/e2e-test-images/agnhost:2.39 -- /agnhost netexec --http-port=8080
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1bd559e6-4358-426c-9f05-3044f6615a7f)

- kubectl get pods
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/92224824-a8c0-4fd2-8349-c0959aa16726)

- kubectl config view | less
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4480d561-4965-4c0b-af16-ed6a1bc47c2d)

- Expose the pod to the public internet using a service:
  - kubectl expose deployment mydeployment --type=LoadBalancer --port=8080
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6c3bcfa0-21e4-49e3-a8f0-f834353fa14b)
  
  - View the service you created: kubectl get services
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f779e051-df1d-4ba8-a299-8be64a908c16)

  - Explore the service you created just now: minikube service mydeployment
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/835731b3-c3d4-48b8-88ac-5dd9be527bc6)

  -  Click on the hyperlink: http://192.168.49.2:30894 It gave an error message because I've created private cluster???
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e707f924-d4c3-49fc-b48c-8d9ffc9578c6)

  - The output of the curl command displays: curl -v http://192.168.49.2:30894
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/521cc3a9-52c2-47c5-aabc-2ed213c7ffb3)
  
- Clean-up: 
  - kubectl delete service mydeployment
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4257832c-2146-43f8-806d-d0a5d2085b3b)

  - kubectl delete deployment mydeployment
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e41944fc-c1e7-4aa1-8de6-ff903448dbbc)

