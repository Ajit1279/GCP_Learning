- Reference: https://www.youtube.com/watch?v=ZAPX21TMkkQ&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=29
- https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling
- https://www.geeksforgeeks.org/push-docker-images-to-artifact-registry-in-gcp/

- Basics:
  - At times, the data within the image should be persistent. e.g. to make the container stateful
  - There are also writable layers (container layer)
  - The data is gone once the container is gone. We use volumes to make the data persistent
  - **Storage Drivers** create the layers within the image and also write the data into writable layers
    - **overlay2:** for ubantu, CentOS, Fedora etc.
    - zfs, vfs:
    - **aufs, devicemapper** are **deprecated**
    - **Cloud Storage Buckets** etc.
  - **Volume Drivers** makes the data persistent (i.e. make it available for user later on)

    ![image](https://github.com/user-attachments/assets/00e2442e-ca29-45fa-a9c9-ed0b4e52bfdb)

---------------------------------------------------
- Demo
  - This is a pre-requisite for the next topic i.e. [K8S volume](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/241021_K8S_Volume.md)

  - Create a [compute VM](https://github.com/Ajit1279/GCP_Learning/blob/main/Compute_VMs/createdockervm.sh), [install Docker](https://docs.docker.com/engine/install/debian/) on it

  - Now let's build a docker image. For this, we'll need a small app first, which can be downloaded from git repository

        mkdir dockerbuild && cd dockerbuild
        git clone https://github.com/docker/getting-started-app
        cd getting-started-app

      ![image](https://github.com/user-attachments/assets/1ec387f1-61e4-4f88-a836-a73710aa997a)


  - Create [Dockerfile](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/Dockerfile). As noted previously, the image consists of 4 layers: base image, creating work directory, copying the files, install yarn

        vi Dockerfile
        sudo docker build -t docvolimage .

      ![image](https://github.com/user-attachments/assets/95014402-4adc-4ba1-ae65-ce5c9f46a014)

        
  - The docker image is read-only, but there are cases wherein the data needs to be persistent across containers as mentioned above, so we create container layer. **Push the image to your registry in the remote docker hub** (Please note the website_on_gke should exist before pushing image to it)

        sudo docker images
        sudo docker tag docvolimage:latest ajit1279/dockervolume:latest
        sudo docker push ajit1279/dockervolume:latest

      ![image](https://github.com/user-attachments/assets/9c5bf0a5-65ae-47bb-81ed-58a39c32bec6)

  - Create a new artificat registry on GCP if it doesn't exist

      ![image](https://github.com/user-attachments/assets/e1edcd70-04e7-4064-86a0-8c9244956ff4)

  - Grant the required permissions to pull and push the images

        gcloud auth configure-docker us-central1-docker.pkg.dev
        gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://us-central1-docker.pkg.dev
 
    
      ![image](https://github.com/user-attachments/assets/c9b020d6-2f98-4074-8e07-e11249ae4076)

    
  - Tag the image and push to the artifact registry

        sudo docker tag docvolimage:latest us-cental1-docker.pkg.dev/test66666666/gcpdockerhb/docvolimage:latest
        sudo docker tag docvolimage:latest us-central1-docker.pkg.dev/test66666666/gcpdockerhub/docvolimage:latest
        sudo docker images
        sudo docker push us-central1-docker.pkg.dev/test66666666/gcpdockerhub/docvolimage:latest
                         
        

  - sd
  - sd
  - sd
  - sd
  - sd
  - s
  - ds
  - ds
  - ds
  - ds
  - d
  - sd
  - sd
  - sd
  - sd
  - s
  - sd  
 
