- **Reference:** https://www.youtube.com/watch?v=ul96dslvVwY&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=3

- **Day1: Docker Fundamentals**
  - **Virtualization:** Allows running multiple operating systems concurrently on a single computer

    ![image](https://github.com/user-attachments/assets/a1337e81-9553-4025-b14c-1ddd20453839)

  - **Docker:**
    - Platform to build, ship and run containers
    - Provides isolated environment containing libraries, application, runtime and dependencies

    ![image](https://github.com/user-attachments/assets/7f9010eb-6bbd-44e2-b6ac-a4414895fd3b)


  - **VM vs Containers:**
    - **VM** is like an **independent house**, **Containers** like **apartment complex** (so there's min wastage of resources)
    - **Hypervisor** allows running **multiple VMs on a single OS**. **Container Engine** allows running **multiple containers on a single OS**.
    - **Containers** are **light weight** and **portable**

  - **Simple Dockerflow**
    - **Dockerfile** - Contains set of instructions to build an image with required configuration. DevOps or Cloud Engineer create this file. One per application
    - **Docker Build** - Create a Docker image from Docker file 
    - **Docker image** - The libraries, dependencies, application etc. are packaged in Docker image. It's shipable from one environment to the other (not the container itself)
    - **Registry** (e.g. DockerHub) - It's not a best practice to push the images directly to dev, test or prod env. Registry act as intermediate layer for storing image binaries, image version control.
    - **Create Environments** - Using "Docker Pull" command, which pulls image from registry
    - **Run Applications** - Using "Docker Run" command, which creates running instance from image  
   
      ![image](https://github.com/user-attachments/assets/1ff57e1b-9f40-4020-81fb-6a8f859e0235)

  - **Docker Architecture**
    - **Dockerfile** - Stored in repositories e.g. GitHub 
    - **Docker Daemon (dockerd)**
      - **Docker build** command is issued to and executed in this daemon to create an **image**, which is stored locally on Docker Host
      - **Docker push** command pushes the image from dockerhost to the remote Registry (e.g. Docker Hub, Artifact Registry, Nexus Registry)
      - **Docker pull** command pulls image from registry to the respective environment i.e. Dev, Test, Prod etc.
      - **Docker run** command is issued to docker daemon, then to container run time to spin-up containers  
   
      ![image](https://github.com/user-attachments/assets/1e6f7333-d468-4e1f-aa28-4de948e4a2dc)
  

  
- **Day2** : [Dockerise a project](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/Docker/240815_DockerOnVM.md)

- **Day3**: Multi Stage Docker build
- sd
- sd
- sd
- sd
- s
- ds
- ds
- ds
- d
- sd
- sd
- sd
- sd
- s
- ds
- ds
- d
- sd
- sd
- sd
- sd
- s
- ds
- ds
- d
- sd
- s
- ds
- ds
- d
- sd
- sd
- sd
- sd
- s
- dsds
