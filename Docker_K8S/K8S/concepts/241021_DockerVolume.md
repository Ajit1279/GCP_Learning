- Reference: https://www.youtube.com/watch?v=ZAPX21TMkkQ&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=29

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
 
