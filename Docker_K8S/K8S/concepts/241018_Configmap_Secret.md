- Reference: https://www.youtube.com/watch?v=Q9fHJLSyd7Q&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=20

- **Basics:**
  - **Configmaps:** It helps to "parameterise" various variables and then inject those values in K8S objects

  - One of the approaches is to mention literals if the numbers is not large 

      ![image](https://github.com/user-attachments/assets/e6c4c217-6e1f-402e-a040-85926b0a9ad2)
    
  - The configmap file can be used directly in the yaml, but the best practice is to mount it as a volume in the **spec.env section**

  - Another option is to mention key value pairs in a file and refer that file. The key value pairs are stored in "Data" section of yaml

      ![image](https://github.com/user-attachments/assets/62470d24-2af6-4915-b114-6afa1e46a484)
     
-------------------------------------------------------
- Demo
  - Create [configmapdemo.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/configmapdemo.yaml)

  -  
