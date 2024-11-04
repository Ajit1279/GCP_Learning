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

   - Create 5 nodes by clicking on the "Add new instance" button on the left. Max 5 nodes can be created at a time.

     ![image](https://github.com/user-attachments/assets/d0c47414-bcf8-48e9-a22e-f2d5f5160219)

   - Initiaite Swarm on one of the nodes, which will then act as a Master Node. Type command: **docker swarm init --advertise-addr=192.168.0.14** (ip address of the node1)

     ![image](https://github.com/user-attachments/assets/4fe92bd5-2c61-419b-98fa-56c81a3f141a)

   - Now we'll need to join node2, node3, node4, node5 with this master/leader node. Copy (CTRL+ insert) the following command from the master node:  **docker swarm join --token SWMTKN-1-5p202jwz8k6b51gbig9nrkh7lbrnmy2svd58zmr92xdsbnxg96-23rchrwzrppwlsg5elad1ufiv 192.168.0.14:2377**  

   - Paste (SHIFT + Insert) the above command in the remaining nodes one-by-one

     ![image](https://github.com/user-attachments/assets/efd10ab3-5bf7-43df-b9cd-70b4197b8060)


     ![image](https://github.com/user-attachments/assets/fa281e66-8b37-4f37-82ba-63c7dc5c889f)


     ![image](https://github.com/user-attachments/assets/96ef0e8f-3925-4f60-ac36-25d7ba29736b)


     ![image](https://github.com/user-attachments/assets/e9bef7ff-5112-4788-8bbf-a3de291d5899)


   - Go to the master node and type: **docker node ls** . As seen in the below screenshot, all nodes are bundled together with node1 as leader

     ![image](https://github.com/user-attachments/assets/7dd2c5be-3544-41a6-adb8-38efba5b83bc)

   - Now let's delete one of the nodes (say node5) and run **docker node ls**. It shows **node5 is down**

     ![image](https://github.com/user-attachments/assets/f94c6633-d180-4ba0-9ef2-4b0d3f967eef)

     ![image](https://github.com/user-attachments/assets/3fce363c-65c1-4717-a5e9-ad4112b329ac)


   - Let's recreate node5 by clicking on "Add new instance command" and run **docker node ls**. It still shows **node5 is down**

     ![image](https://github.com/user-attachments/assets/4e391e56-b7cc-4de4-a5ef-78205ebf50d2)

     ![image](https://github.com/user-attachments/assets/812760cb-ceac-4fed-bb53-b133c37feac8)

     
   - Now let's delete the master node itself

     ![image](https://github.com/user-attachments/assets/99c739c5-4476-49ee-a1b6-aae2d73b4eff)

   - If we run the command: **docker node ls** now on remaining nodes, it gives an error message: **_Error response from daemon: This node is not a swarm manager. Worker nodes can't be used to view or modify cluster state. Please run this command on a manager node or promote the current node to a manager._**

     ![image](https://github.com/user-attachments/assets/d10409b7-6522-4f84-8169-94680d6cf12d)

     ![image](https://github.com/user-attachments/assets/5c66a626-6b6b-4765-ab98-a911d40cffec)

 ------------------------------------------------------------------
