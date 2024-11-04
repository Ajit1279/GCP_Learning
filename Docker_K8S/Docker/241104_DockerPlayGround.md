 - Reference: https://www.youtube.com/watch?v=PqgJXtZWDs0
 
 - Let's use docker playground from this lab onwards. Please type **https://labs.play-with-docker.com/**
 
 - It creates a temporary instance for 4 hours

    ![image](https://github.com/user-attachments/assets/9d097738-0c56-4098-9995-faf5e84f5d3c)
   
 - There are few configuration options available if you click on the spanner:

   ![image](https://github.com/user-attachments/assets/e82e0f20-1538-4b39-b2d7-c19a3599b4ed)

 - To create another node, click on "add new instance" button on the left   

 - To download images type docker pull command e.g. for ubuntu type: **docker pull ubuntu**

   ![image](https://github.com/user-attachments/assets/f31b21b8-c62b-4a90-9783-de9dee37e8b6)

 - To spin-up the container type: **docker run -d -t --name ajit ubuntu**

   ![image](https://github.com/user-attachments/assets/b19cc25b-e8fa-4711-9f47-7992163c822e)

 - Type: docker ps , it'll show the running container details:

   ![image](https://github.com/user-attachments/assets/964b81ef-b011-462c-9c4e-a69aac761d42)

 - To stop the container use command: docker stop ajit

   ![image](https://github.com/user-attachments/assets/be45acde-1936-43b8-940f-7d9f736a204a)

 - If you want to find out all other available images, go to https://https://hub.docker.com/
 
 - [Install kubectl](https://hub.docker.com/r/bitnami/kubectl) using command: docker run --name kubectl bitnami/kubectl:latest 

    ![image](https://github.com/user-attachments/assets/9360ea66-1a9e-4e77-bdf2-88f36017a50b)

 - To [install nginx](https://hub.docker.com/_/nginx) type: docker run --name some-nginx -v /some/content:/usr/share/nginx/html:ro -d nginx

   ![image](https://github.com/user-attachments/assets/345ae0e5-2eec-438a-a736-04a8fbc98350)

   ![image](https://github.com/user-attachments/assets/c13580fa-0e02-4f50-bf1b-806bef3c84fb)

 - Alternatively you can type: **docker container run -d --name my-nginx-container -p 80:80 nginx**

   ![image](https://github.com/user-attachments/assets/c72d48c3-b852-41b8-b694-eec916cf2010)

   ![image](https://github.com/user-attachments/assets/c379420e-181a-449d-adf9-bca3e1a2fbe8)

 - With the above command, we've also enabled port 80 of this instance:

    ![image](https://github.com/user-attachments/assets/a40fa7ab-2fd9-4e88-a444-b4d9d61b45c1)

 - If we click on the port, it opens the new browser window:

   ![image](https://github.com/user-attachments/assets/363dda50-5d22-45b4-86d9-3e6f0f3b21fd)

 - To [create a Swarm cluster](https://www.youtube.com/watch?v=KLTT4FfiKHQ): 3:15
   - Create 4 nodes by clicking on the "Add new instance" button on the left 
   -  
