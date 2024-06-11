- Reference: https://cloud.google.com/dataform/docs/sql-workflows
  
- You can develop SQL workflows with Dataform core, using SQLX files or with JavaScript.
- It consists of:
  - [Data Source Declarations](https://cloud.google.com/dataform/docs/declare-source):
    - Create dataset-declaration.sqlx file and declare a datasource

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9cae8683-eca7-4f84-8834-f695dc1bd473)

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ab2ebd2a-604a-4070-bbe0-6913a1d174f1)

  - [Declare dependencies](https://cloud.google.com/dataform/docs/dependencies)
    - The dependency declarations make up a dependency tree that determines the order in which Dataform executes SQL workflow objects.
    -  

  -    

    



  -    

- Reference: https://cloud.google.com/dataform/docs/quickstart-create-workflow

- [Create a view](https://cloud.google.com/dataform/docs/quickstart-create-workflow#create-view) 
  - Create a SQLX file for defining a view
    - In the Files pane, next to definitions/, click the more_vert More menu.
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2307f24b-13c7-4d65-94c9-e2e007b0cb82)

    - Enter file name and click on "Create file"
   
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/41e1111f-0eee-4bb7-baaa-d2933083de3d)

    - Enter the following code snippet in the file and click on "format"
      
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7d234972-6cdd-4d51-b971-b46bd10b9778)

- [Create a table](https://cloud.google.com/dataform/docs/quickstart-create-workflow#define-table)
  - Create a new file _quickstart-table.sqlx_ in the same path i.e. _definitions/quickstart-table.sqlx_

  - Enter the code and click on format

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/56929bba-cf7b-4e0e-9f9f-3749525db3f5)

  - It gives compilation error because quickstart-source does not exist in BigQuery yet. This error is resolved when you execute the SQL workflow later:

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/cf57ebf9-5aae-461d-aa84-e5d50cb8758b)

- [Grant Dataform access to BigQuery](https://cloud.google.com/dataform/docs/quickstart-create-workflow#grant-access-bigquery)

  - Go to IAM >> Permissions >> View by principals >> Grant Access. 

  - Enter the default service account and enable **BigQuery Job User**, **BigQuery Data Editor** and **BigQuery Data Viewer** roles

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2adb160e-9dc9-4b89-ad07-9dde44262a08)

- [Execute the workflow](https://cloud.google.com/dataform/docs/quickstart-create-workflow#execute-workflow)

  - In the console go to Dataform >> Start Execution

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fa4d652a-f106-4664-9133-f3425490868f)

  - In the next screen select "All Actions" and click on "Start Execution"
 
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/050781ae-f076-48a9-ad60-10acaf172ff0)
           

  - A message stating "successfully created workflow execution" is displayed.

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7614b8b5-3d95-49bb-a961-951a1b1a7ced)


  - Click on "Details"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/114f5db2-b742-4886-b0d1-c5b8e4ec886b)

  - The tables and views are created in Dataset

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0718ee92-e1cb-4e55-be7e-957c308c7695)


- To avoid incurring charges delete the dataset and the workspace

  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/da954be9-98d8-432d-b83f-4b8f39a65025)

