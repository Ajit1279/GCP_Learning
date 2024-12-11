- Reference: https://www.youtube.com/watch?v=cNPyajLASms&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=38
- Reference: https://github.com/kubernetes-sigs/metrics-server
 

- Basics:
  - Kubelet does container management at node level, it set-up communication between worker node and control plane. It also collects pod data
  - cAdvisor only collects matrix from container runtimes, aggregates and share with kubelet 
  - Mertics server will need to be installed on K8S which exposes these to API server. 

    ![image](https://github.com/user-attachments/assets/abfba7bc-40e9-40f3-a1a1-eca0734e42e2)

  - docker was the default container run time in earlier versions. Now we have crictl

 --------------------------------------------------
 Demo
 - [Create VM instance, install docker, kind and K8S Cluster on it](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md)
 
 - Check if the cluster is created with the required nodes

       sudo kubectl get nodes

     ![image](https://github.com/user-attachments/assets/a080bb45-8463-4dd5-8501-08b044ea1cba)

 - Let's download matrics server and install objects

       sudo kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

     ![image](https://github.com/user-attachments/assets/6d902bb2-37b7-4472-bfa9-bae614beaaad)

 - A matrics server pod will be created in kube-system namespace. 

       sudo kubectl get pod -n=kube-system 

     ![image](https://github.com/user-attachments/assets/c74610e8-9c4c-4184-8342-7e1cbc31ab22)

 - It'll take few mins for it to be up, so let's add watch to it

       sudo kubectl get pod -n=kube-system -w

      ![image](https://github.com/user-attachments/assets/5f70d05c-ba34-4457-8d82-8d49c98e9415)


 - It's taking long, so let's run the below command in another window. IT shows an error "Readiness probe failed: HTTP probe failed with statuscode: 500"

       sudo kubectl describe pod metrics-server-75bf97fcc9-zq4b4 -n=kube-system

     ![image](https://github.com/user-attachments/assets/18761082-f0ba-4084-8598-7aac156f322e)

 - Let's access the logs for more details. The error message says: "cannot validate certificate for 172.18.0.2 because it doesn't contain any IP SANs" node="kuberlearn-control-plane""

       sudo kubectl logs metrics-server-75bf97fcc9-zq4b4 -n=kube-system

     ![image](https://github.com/user-attachments/assets/205d8041-5a25-4b9a-a153-b25034dffe04)

 
 - Let's edit the deployment metrics-server, go to the container section and add an argument mentioned in [github](https://github.com/kubernetes-sigs/metrics-server) readme configuration section so that it does not validate certificate

     ![image](https://github.com/user-attachments/assets/e86c141e-6d9e-4d8b-9ec0-8fc7a0fe750e)


        sudo kubectl edit deploy metrics-server -n=kube-system

     ![image](https://github.com/user-attachments/assets/8fef1110-7c9d-49c9-a8f1-83cb62fd6947)

    It says deployment edited

     ![image](https://github.com/user-attachments/assets/c49c0230-5af3-4538-8c32-64d93745cd65)

 - Now let's check again if the pod is running

        sudo kubectl get deploy -n=kube-system

     ![image](https://github.com/user-attachments/assets/1e52fff1-3826-4fef-8756-52a6c2d78987)

 
 - Let's check if pod is running

        sudo kubectl get pod -n=kube-system

     ![image](https://github.com/user-attachments/assets/019f7a1e-87e9-477f-b467-7c98b6c34559)

 
 -  Type the command to check if the node matrics are available. It may take a while for the metrics to be available
 
        sudo kubectl top node

     ![image](https://github.com/user-attachments/assets/d63b3c87-8018-4e2b-8c69-905c53a00caf)

 - These logs can be exported to third party monitoring tools like Splunk, Prometheus for creating dashboards
