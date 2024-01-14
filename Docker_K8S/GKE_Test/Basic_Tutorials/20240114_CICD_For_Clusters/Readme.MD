- Clone git repository: git clone https://github.com/GoogleCloudPlatform/cloud-deploy-tutorials
  
- Change into directory and set-up workspace: cd cloud-deploy-tutorials/tutorials/e2e-gke && cloudshell workspace .
  
- **Deploy Infrastructure:**
  - Run **./setup.sh** to deploy three GKE clusters with the names: test, staging, prod.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d62fcac3-c9b5-4f22-8584-10faa8668dec)

  - It takes approx 10 min to complete and displays the below message when completed

  - To confirm the resources are properly deployed, run the command: gcloud container clusters list



- **Build an Application**
  - As part of this tutorial, a sample application from the Skaffold (a leading open-source CD toolset). GitHub repository is available from your Cloud Shell instance, in the web directory.
  - The web directory contains **skaffold.yaml**, which contains instructions for skaffold to build a container image for your application. 
  - Run the following command to run the container images
        cd web && skaffold build \
            --interactive=false \
            --default-repo $(gcloud config \
            get-value \
            compute/region)-docker.pkg.dev/modular-citron-402808/web-app \
            --file-output artifacts.json \
            && cd ..  

  - Once completed, it'll display

- d
- sd
- sd
- s
- ds
- ds
- d
- sd
- s
- ds
- s
- ds
- 
