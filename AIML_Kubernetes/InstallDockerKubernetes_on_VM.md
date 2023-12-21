1. Create a VM manually or using terraform script
2. Follow instructions at https://docs.docker.com/engine/install/debian/ to install docker desktop (To be expanded later)
3. Install Minikube by referrring instructions at: https://minikube.sigs.k8s.io/docs/start/
4. Follow tutorials at: https://minikube.sigs.k8s.io/docs/tutorials/
5. Refer this site for basic controls: https://minikube.sigs.k8s.io/docs/handbook/controls/
6. Start a cluster by running: *minikube start* It'll display as shown below:
   ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/dab1e9c2-e923-4b07-81da-385b9c4b9179)

7. It also says kubectl not found. If you need it, try: 'minikube kubectl -- get pods -A' . It'll display as shown below:
     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8d5067e1-ebc3-405e-b830-b72453cfbf8e)

8. but when tried running again, it gave an error: 
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f3bab44d-ee3e-45eb-8ab3-afe38350b203)

9. Referring to the https://stackoverflow.com/questions/55360666/kubernetes-kubectl-run-command-not-found
    Run the following commands: 
    i. Download the latest Kubernetes release with the command: curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    ii. Make the kubectl binary executable: chmod +x ./kubectl
    iii. Move the binary in to your PATH: sudo mv ./kubectl /usr/local/bin/kubectl
    iv. Test the installation is successful or not: 
          kubectl version:
            ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ec301a0e-9c21-456d-b863-4bb9809e5b20)

          kubectl cluster-info:
             ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/39862ce5-5840-493e-86e4-39cba47f363e)

10. Ran the minikube dasboard command again and it gave an error:
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/acfb1ff9-31d9-439c-9c8e-7f58165a3f48)
      when Opened in browser: Let's revisit this later!!! CTRL+c to exit
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d64143f5-3cbf-4f36-ac69-9e05ee1ef4a6)

11. Now 
    i. let's create a deployment named "hello-minikube" : kubectl create deployment hello-minikube --image=kicbase/echo-server:1.0 It displays message
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/47026fde-3515-4f4c-8f76-ebd556f203a6)

    ii. Expose service as node port: kubectl expose deployment hello-minikube --type=NodePort --port=8080
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/27b20edf-6040-4bcc-a302-68b29e2fe653)

    iii. Open this exposed endpoint in your browser: minikube service hello-minikube  it didn't give any error but it didn't work :(  Let's tackle this later as well!
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/30e3d88c-fbb5-4a6e-bd34-490e2e80e77e)
        ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/aa6cc213-6ab7-4bf6-b542-9618f8f5fdbe)

12. Start a second cluster: minikube start -p cluster2

13. Display the list of contexts: kubectl config get-contexts
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/80f27837-ba9f-4087-ba66-f2bcb9a2ed1c)

14. Refer more on: https://kubernetes.io/docs/reference/kubectl/quick-reference/ 

15. Creating Objects: Kubernetes manifests can be defined in YAML or JSON. The file extension .yaml, .yml, and .json can be used.






    
10.
11.
12.
13.
