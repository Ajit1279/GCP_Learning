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

  - Follow the [instructions to create Docker image and push it to the GCP Artifact Registry](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/Docker/240815_DockerOnVM.md) upto creating a docker image

  - Run command to create container from this image
        sudo docker run -dp 3000:3000 --name=docvol mydocimage

    ![image](https://github.com/user-attachments/assets/319cbf30-518d-4603-a85d-785d187d6696)

  - sudo docker ps didn't display anything

      ![image](https://github.com/user-attachments/assets/d676d992-2b2c-40f7-88d8-19ee8a122499)

  - Let's troubleshhot by typing command:

        sudo docker ps -a

      ![image](https://github.com/user-attachments/assets/2ce83a79-743f-44fd-8b25-2ec76670503d)


  - Access the container logs

        sudo docker logs docvol

      ![image](https://github.com/user-attachments/assets/97fe5aa6-bbd4-4d98-b098-c624b54cbefb)

  - The container was created after the path for index.js in CMD was corrected in Dockerfile (src/index.js instead of ./index.js)

      ![image](https://github.com/user-attachments/assets/516b1519-2de0-443d-be67-0686a172b975)

  - The image has **4 read-only layers** . The **container layer is editable**, but please note however that **this data will be persistent only for the lifetime of a container**. **Storage Driver** is responsible for **writing data into container and storing read-only layers in container.** 

        sudo docker exec -it 8cf7eb1dbe4d sh
        mkdir test

      ![image](https://github.com/user-attachments/assets/88124754-cf1b-4644-9ad4-7bf506d452db)


  - To make this **data persistent** we will use volumes, **it's a responsibility of volume drivers.**

  - Stop and remove the container

        sudo docker stop 8cf7eb1dbe4d
        sudo docker rm 8cf7eb1dbe4d

  - Let's create a new volume. The command below creates local driver at cd /var/lib/docker, but getting permission denied

        sudo docker volume create data_volume
        sudo docker volume ls
 
        cd ..
        cd ..
        cd var
        sudo ls -lrt
        cd lib
        sudo ls -lrt
        cd docker
        

      ![image](https://github.com/user-attachments/assets/8cba5788-3533-4cd1-86ce-81e97a45c1f9)

      ![image](https://github.com/user-attachments/assets/f92f564f-88cb-4ffb-929a-b32af284478c)

      ![image](https://github.com/user-attachments/assets/fd61a58c-c24e-4285-b54d-149f89438dc9)

      ![image](https://github.com/user-attachments/assets/30a82df7-833d-4d2c-9fff-b97cd8856ab7)


  - Now let's mount this volume on container (data_volume is volume created and app is directory on a container, docvol is container name and mydocimage is image name)

        sudo docker run -v data_volume:/app -dp 3000:3000 --name=docvol mydocimage
        sudo docker ps
        

      ![image](https://github.com/user-attachments/assets/0c362266-72f3-4f62-b6e0-0f56118c62b8)

      ![image](https://github.com/user-attachments/assets/16f0447f-2554-4dd1-9134-3ce238263f19)


  - Login into container

        sudo docker exec -it e6b085da77ce sh
        mkdir test_demo
        exit

      ![image](https://github.com/user-attachments/assets/cabaf30c-0c01-4e73-9645-0b121d16487f)
 
      ![image](https://github.com/user-attachments/assets/64ed612e-4271-4a57-b251-9ecb5ae345e7)



      ![image](https://github.com/user-attachments/assets/34fe27fe-3fd2-469c-b459-c3bec6b39dc3)


