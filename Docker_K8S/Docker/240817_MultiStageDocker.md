- Reference: https://www.youtube.com/watch?v=ajetvJmBvFo&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=4
- Reference: https://github.com/piyushsachdeva/todoapp-docker/tree/main/src

- Useful for:
  - Reducing image size
  - Improve performance of Docker container


- Step-by-step instructions
  - Create a GCP vm instance, SSH into it.
  
  - [Install Docker](https://docs.docker.com/engine/install/debian/) on it. Please refer steps [here](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/Docker/240815_DockerOnVM.md).

  - Verify if docker is installed successfully by running a command: _**sudo docker run hello-world**_ 

  - Create a directory (e.g. build) and go to that directory

    ![image](https://github.com/user-attachments/assets/b1497c42-080b-4512-9d4b-653a21efecc4)

    
  - Create a [Dockerfile](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/Docker/Dockerfile_MultiStage)
 
  - Run the command: _**sudo docker build -t multistage .**_

  - It returned npm installer error: ERROR: failed to solve: process "/bin/sh -c npm install" did not complete successfully: exit code: 254

    ![image](https://github.com/user-attachments/assets/9d2af13a-66b4-4a8a-95db-62152e4e0725)

  -   


-  
