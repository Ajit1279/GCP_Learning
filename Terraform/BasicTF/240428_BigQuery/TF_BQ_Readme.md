- References: https://cloud.google.com/bigquery/docs/datasets#terraform
- Instructions
  - Create [main.tf](https://github.com/Ajit1279/GCP_Learning/blob/main/Terraform/BasicTF/240428_BigQuery/main.tf)

  - Run the commands terraform init, terraform plan and terraform apply

  - It gave an error message
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e0ae9d88-7d72-4356-96b6-4749d698fb93)

  - Corrected the parameter and re-ran.

  - Dataset created:
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1f53d935-b640-40e9-94c1-c4768c5e0ede)

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/10a4886d-b7fe-4d39-8107-49d86468b843)

  - Create a Service Account:
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8c639399-3704-4c1e-9da9-c5c47c6e4538)

  - Run terraform script to grant access. Go to BigQuery >> Dataset >> Right click >> Share >> Manage Permissions
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ec5af859-1635-4fad-841e-fedbc4dddba2)

  - Observe all the permissions
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d7113aea-bc38-467d-bda3-4a26b5d6933b)
  
  - Now let's [create a table](https://cloud.google.com/bigquery/docs/tables#terraform)
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/bc370121-6c2b-42f6-9e07-2f751dfeae5d)

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d8e30741-db78-40e6-a19f-c6483cd9371a)

  - One can also [create external data tables](https://cloud.google.com/bigquery/docs/external-data-sources)

  - You can also [create views](https://cloud.google.com/bigquery/docs/views#terraform)   
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
