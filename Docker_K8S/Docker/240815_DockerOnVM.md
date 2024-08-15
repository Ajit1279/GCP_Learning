- Create a Debian VM on GCP

  ![image](https://github.com/user-attachments/assets/9c56fac4-8b0a-4b77-8987-98ab18559d0e)

- SSH into VM

- [Install Docker](https://docs.docker.com/engine/install/debian/)
  - Run the following command to uninstall all conflicting packages: for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

  - Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker apt repository.

  - Then install latest Docker packages: sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    ![image](https://github.com/user-attachments/assets/e58f9d97-e9a8-48dc-8b7b-a0374d4fc56a)


  - Verify that the installation is successful by running the hello-world image: sudo docker run hello-world

    ![image](https://github.com/user-attachments/assets/1888981a-59a6-488b-ac4a-297f3aff694e)


- Now let's build a docker image. For this, we'll need a small app first, which can be downloaded from git repository
  - Create a new directory e.g. build
    
  - Clone the [docker git repo](https://github.com/docker/getting-started-app) in it : git clone https://github.com/docker/getting-started-app

    ![image](https://github.com/user-attachments/assets/f15089e4-0907-4ed2-95ef-fbd7a58fbda3)

  - Change directory to getting-started-app and create Dockerfile
    - We first need a base image. Go to https://hub.docker.com/search?image_filter=official
    - Let's pull Python image:   

  -       
