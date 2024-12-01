- 1. Create a Debian VM on GCP

  ![image](https://github.com/user-attachments/assets/9c56fac4-8b0a-4b77-8987-98ab18559d0e)

- 2. SSH into VM

- 3. [Install Docker](https://docs.docker.com/engine/install/debian/)
  - Run the following command to uninstall all conflicting packages: _for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done_

  - Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker apt repository. Please follow the instructions on Docker portal

  - Then install latest Docker packages: _sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin_

    ![image](https://github.com/user-attachments/assets/e58f9d97-e9a8-48dc-8b7b-a0374d4fc56a)


  - Verify that the installation is successful by running the hello-world image: _sudo docker run hello-world_

    ![image](https://github.com/user-attachments/assets/1888981a-59a6-488b-ac4a-297f3aff694e)

    ![image](https://github.com/user-attachments/assets/29459ccc-4fd0-4a5e-9d72-a2a4354f1c17)
    

- 4. Now let's build a docker image. For this, we'll need a small app first, which can be downloaded from git repository
  - Create a new directory e.g. build : mkdir build && cd build
    
  - Clone the [docker git repo](https://github.com/docker/getting-started-app) in it : _git clone https://github.com/docker/getting-started-app_

    ![image](https://github.com/user-attachments/assets/f15089e4-0907-4ed2-95ef-fbd7a58fbda3)

  - **Create Dockerfile**
    - Change directory to getting-started-app : _cd getting-started-app_
      
    - Create [Dockerfile](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/Docker/Dockerfile): _vi Dockerfile_ and press Esc, then i

      - We first need a base image for operating system. Although you may be using OSs like ubantu, centos etc., we need an OS with node installed on it, as it provides the required node images listed on [Docker Hub](https://hub.docker.com/search?image_filter=official) 

      - Go to the above page and search for the desired image. Let's use node js image for this exercise: _**FROM node:3-alpine**_   

      - Next provide the working directory within container where all the required work is supposed to be completed: _**/usr/src/app**_

      - Copy the files from cloned repository on VM (current working directory) to the working directory of container: _**COPY . .**_

      - Run using "yarn" as a package manager and environment (say production): _**RUN yarn install --production**_

      - CMD will actually be executing the above commands on container. We'll instruct container to run **node** application using the dependency (index.js) in the current working directory: _**CMD ["node","./index.js"]**_              

      - The application has to be exposed on a specific port to make it available to the end users: EXPOSE 3000
     
  - **Build Docker image**: _**sudo docker build -t testdocimage .**_

     The above command creates a docker image named **testdockimage** using the file in **current directory** "(.)"
    
  - The image creation is complete:
  
    - The images are created in layers depending on configuration in Dockerfile. When you push the image, all those layers are dis-integrated, shipped to destination, and then integrate again in one package. This helps in faster processing, maintaing docker image etc.

    - Referring to the screenshot, it says [1 / 4], [2 / 4] etc. so there are 4 layers    

    ![image](https://github.com/user-attachments/assets/efd00158-4646-4c21-a948-50340b4d5882)

    - The docker image is read-only. If we want to make any changes to the image, the **docker file needs to be changed** and **image needs to be built again**. Also, only the changed layers are updated

  - To see the images run the command: sudo docker images

    ![image](https://github.com/user-attachments/assets/e253570d-4906-45ee-8f4b-0aee45d345da)

- 5. **Push the image to your registry in the remote docker hub**

  - Login to docker hub using: _**sudo docker login**_

  - Enter your credentials:

    ![image](https://github.com/user-attachments/assets/f15dbad0-7d60-479d-8dbf-1c223d7cdddd)

  - Type the command:

    gcloud artifacts repositories create quickstart-docker-hub-remote \
    --project=test66666666 \
    --repository-format=DOCKER  \
    --location=us-central1 \
    --description="Remote Docker repository" \
    --mode=remote-repository \
    --remote-repo-config-desc="Docker Hub" \
    --remote-docker-repo=DOCKER-HUB \
    --remote-username=ajit1279 \
    --remote-password-secret-version=projects/PROJECT/secrets/mydockersecret/versions/1

  - It gave an error:

    ![image](https://github.com/user-attachments/assets/183e24d1-83e6-467d-a3c5-f80c02809238)


  - Let's stop the VM, and edit it to grant permissions to access all APIs (Please note that this option is _not recommended_ in real world due to security reasons). Save and restart the VM. 

    ![image](https://github.com/user-attachments/assets/436f382f-1722-46f3-9545-a8c874b711da)
 

  - SSH into machine again, change the directory to build/getting-started-app, and run the above commands all over again from docker login
 
  - There was an error still

    ![image](https://github.com/user-attachments/assets/8f3d9acf-5b16-4ec7-bf2a-92b6c5ee0486)

  - Enable the "Service Usage API" by going to the API in cloud Console

    ![image](https://github.com/user-attachments/assets/b8bd9575-1201-47e9-99aa-8db3f53ed562)

  - Run the command to grant Service Account the required access:
    _**gcloud projects add-iam-policy-binding test66666666 --member='serviceAccount:service-1006430257477@gcp-sa-artifactregistry.iam.gserviceaccount.com' --role='roles/secretmanager.secretAccessor'**_

  - There was an error still, so let's create repository manaully for now

    - Go to Docker Hub and login using your credentials

    - Create a repository named testdocker. Copy the command displayed while creating repository: _**docker tag local-image:tagname new-repo:tagname**_  

      ![image](https://github.com/user-attachments/assets/5b9184d1-1b60-4d82-9602-012b1b785983)

    - Modify the command copied above and run on VM: _**sudo docker tag testdockimage:latest ajit1279/testdocker:latest**_

    - Run the command: _**sudo docker images**_ . It displays:
 
      ![image](https://github.com/user-attachments/assets/90224a09-327f-4f29-8082-a910ff46d5f5)


    - Please note that in the above screenshot, the **image id** is the **same**, but **repository names are different**

    - Now let's push the docker image: _**sudo docker push ajit1279/testdocker:latest**_

    - Once completed, it displays the message:

      ![image](https://github.com/user-attachments/assets/1445290b-2e69-48bf-8519-d543eefbdf5a)
      

    - Go to the repository, and then to the image that you pushed just now. It displays the details:
 
      ![image](https://github.com/user-attachments/assets/6522bcb5-9565-49e3-814c-5f0f775cfe04)
 
    
    - Also, if you compare the image size on local (219 MB) and docker hub (81.79 MB), you'll realize that docker has compressed the image size.   
     
    
- **6. Run the container to create an environment**
  - You can copy the command from the Repository itself: _**sudo docker pull ajit1279/testdocker:latest**_

    ![image](https://github.com/user-attachments/assets/3bb910e9-09d6-4d26-8459-b2e9e593c0f1)

    
  - Because there were no changes after we uploaded, it displays the message as shown below:

    ![image](https://github.com/user-attachments/assets/33f2f62f-1c26-4b9d-b308-9ddb52781bd0)


  - Now run the command: _**sudo docker run -dp 3000:3000 ajit1279/testdocker:latest**_  In this command:
    - d: indicates "detatch" i.e. run the command in the background mode
    - p: to open the port
    - 3000: the port on the local
    - 3000: port on the remote machine

  - It displays the container id:

    ![image](https://github.com/user-attachments/assets/e342789f-deb5-457d-a5d9-57922783e20f)


  - Now type the command: _**sudo docker ps**_ , but nothing was displayed

    ![image](https://github.com/user-attachments/assets/fe029441-3575-434c-a8f3-5f17f92fc1eb)

    
  - So let's troubleshoot. Tried running the command without -dp 3000:3000 included. It showed that index.js path in Dockerfile was incorrect.

  - So ran the command after correcting file and it ran successfully:

    ![image](https://github.com/user-attachments/assets/13dcad83-5f61-4348-a023-7d4e2670045c)

- **7 Log into Container**
  - To troubleshoot any issues you can log into container (like SSH into VM) using it's random name ("agitated_haibt" in this case): sudo docker exec -it agitated_haibt sh 

  - You are into container now:

    ![image](https://github.com/user-attachments/assets/db394fe9-7f44-4e17-a74c-c90aa3accf2b)


  - Type some command e.g. ls -lrt

    ![image](https://github.com/user-attachments/assets/34bef80f-0ddb-4964-92a6-a7251e1c9c0e)


  - Type exit to logoff from container

- **8 Clean-up**
  - Remove the directory from your VM: rm -r build
  - Delete the repository from the Docker Hub
  - Delete the VM and secret in GCP Console
 
---------------------------------------
References: https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling

https://www.geeksforgeeks.org/push-docker-images-to-artifact-registry-in-gcp/

https://www.googlecloudcommunity.com/gc/Developer-Tools/Permission-quot-artifactregistry-repositories-uploadArtifacts/m-p/541769

- The steps below explain pushing docker image to the Google Artifact Registry
  - [Create VM instance](https://github.com/Ajit1279/GCP_Learning/blob/main/Compute_VMs/createdockervm.sh)

  - [Install Docker on it](https://docs.docker.com/engine/install/debian/)

  - Now let's build a docker image. For this, we'll need a small app first, which can be downloaded from git repository

        mkdir dockerbuild && cd dockerbuild
        git clone https://github.com/docker/getting-started-app
        cd getting-started-app
    
  - Create [Dockerfile](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/Dockerfile). As noted previously, the image consists of 4 layers: base image, creating work directory, copying the files, install yarn

        vi Dockerfile
        sudo docker build -t mydocimage .

      ![image](https://github.com/user-attachments/assets/0471cd06-b5e2-4aba-9943-2597a43ca133)

  - Push the image to your registry in the remote docker hub. Let's create a Artifact Registry   

        gcloud artifacts repositories create my-gcp-dockerhub \
            --repository-format=docker \
            --location=us-central1 \
            --description="My Dockerhub on GCP" \
            --immutable-tags \
            --async

      ![image](https://github.com/user-attachments/assets/f6432c95-0b7e-405e-824e-a4cb170eeab7)

      ![image](https://github.com/user-attachments/assets/4435d87a-d461-4eea-805c-205ecdc1d484)

  - Tag the image with the tag

        sudo docker tag mydocimage:latest us-central1-docker.pkg.dev/test66666666/my-gcp-dockerhub/mydocimage:latest
        sudo docker images

      ![image](https://github.com/user-attachments/assets/2bf27609-bed3-4044-bcfc-cb7375aba9ff)

  - Configure authentication for Artifact Registry

        sudo gcloud auth configure-docker us-central1-docker.pkg.dev
        sudo usermod -aG docker $USER
        gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://us-central1-docker.pkg.dev

      ![image](https://github.com/user-attachments/assets/0b1b5aa9-d77b-454c-9950-5b68a7431d71)

  - [Assign Artifact Registry Reader and Artifact Registry Writer role](https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling) to the user / Service Account
    
  - Push the image to the Remote Docker Hub on GCP

        sudo docker push us-central1-docker.pkg.dev/test66666666/my-gcp-dockerhub/mydocimage:latest

      ![image](https://github.com/user-attachments/assets/45a85138-7027-4724-8d07-4bdacc759069)

      ![image](https://github.com/user-attachments/assets/74f7251c-c399-4b1d-9aa7-c1f0bb1eadf3)

