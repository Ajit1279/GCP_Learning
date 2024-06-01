- Reference: https://cloud.google.com/bigquery/docs/spark-procedures

- Objective is to **create and run Spark stored procedures in BigQuery** written in Python, Java, and Scala
- Apache Spark™ : **Multi-language engine** for executing data engineering, data science and machine learning on **single-node machines or clusters**.

- **Steps to create Spark Procedure:**
  - Enable the BigQuery Connection API (if not done already)
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a6143448-e6b8-4c5a-a9ee-5b15f054ab87)

  - Go to BigQuery >> BigQuery Studio >> ADD >> Connections to External data sources
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f92c60cb-c798-4a21-b162-6f80698ee111)

  - Select Apache Spark in Connection Type
  
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/40bc4756-007e-4695-9261-6be41f46e982)

  - Fill-up the remaining details and then click on "Create Connection"
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e627a8a3-60c0-4618-a2c2-5d32fc9287e4)

  
  - A message is displayed when the connection is created

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7939363f-5e4d-4d37-8bb8-1ae647b71f34)

  - Go to the connection
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/84347134-7642-4c3c-b59e-86be16f3f78e)

  - [Create a stored Procedure for Apache Spark](https://cloud.google.com/bigquery/docs/spark-procedures)
    - In the PySpark editor, click on the More >> PySpark Options

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4de64472-a69b-4738-aaaf-0a5fced8e75c)

      
    - Select appropriate values in dropdown and click SAVE
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/eee58f06-becd-4068-9465-3f9430cb26cf)

    - Type the [sample code](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240519_Console/BQPySpark.py) provided in the **Google PySpark Documentation** in the editor
      
  
    - There's a syntax error:
      
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4c4a70c3-07bb-40de-85a6-b8005f6d1b86)


    - Modified the query by referring to the Spark Documentation and then it ran successfully
      
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/cca0b2f5-317c-4f5a-a24d-41309489f7da)


    - You can open the procedure by expanding the dataset
      
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d4b8d4c8-b0da-4e86-be93-e355b6f64bea)

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2e1de03d-67c4-4abb-a111-209898734bb7)

      


- [Steps to call a Spark Stored Procedure](https://cloud.google.com/bigquery/docs/spark-procedures#call-spark-procedure)
  - Go to BigQuery >> BigQuery Studio >> GCP Project (mybqproj0427) >> Dataset Name >> Routines >> Right Click on Procedure Name (spark_proc) >> Invoke
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4c66154f-41d4-47f1-bf8b-767d74782337)

  - In the next screen click on Run:
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d925edb2-59e7-4707-915e-41c589f6352d)

  - Query completed, but there was an error
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fa7071ca-792b-438c-9810-ed5f364659b8)

  - Go to "Execution Details" tab to display "Logs"
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/85729bc3-eb1e-402a-9560-5bca6a22bfe0)


  - Further deep dive in the logs shows User Bigquery Readsessions Permission Error
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fd772e52-2465-4f88-ab32-901b4cdace6d)


  - To assign the permission Go to IAM >> Select User >> Add a Role >> BigQuery >> BigQuery Read Session User
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9e1f7cdd-6331-4568-b204-ebe61aa6ad29)

  - It failed with the same error again. So assigned the permissions to the Service Account, but no luck!!

  - 
    


  -          
