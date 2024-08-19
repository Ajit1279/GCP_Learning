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

  - The error was as a result of missing step which clones the above repo in the virtual machine: _**git clone https://github.com/piyushsachdeva/todoapp-docker**_

  - Ran the docker build command again after repo cloned and Dockerfile moved to new directory cloned repository
    
    ![image](https://github.com/user-attachments/assets/85481343-854d-440e-8a47-3f9afa1d8a13)

  - The iamge created successfully: _**sudo docker images**_

    ![image](https://github.com/user-attachments/assets/ecf15dc9-5b84-44b5-a30d-f684c3f95a95)


  - Run the commands to run the container: _**sudo docker run -it -dp 3000:3000 multistage**_ and _**sudo docker ps**_

    ![image](https://github.com/user-attachments/assets/3961a35e-4e0b-48d7-8779-fae7bf52fae4)


  - Check the container logs: _**sudo docker logs 7d506d3f3dbe**_ (where 7d506d3f3dbe is the container id)

    ![image](https://github.com/user-attachments/assets/102a1af4-c096-4ca8-a939-74e900a5ee06)

    
  - 
    

  -    
