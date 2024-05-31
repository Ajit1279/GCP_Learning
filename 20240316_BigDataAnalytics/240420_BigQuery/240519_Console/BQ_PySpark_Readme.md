- Reference: https://cloud.google.com/bigquery/docs/spark-procedures

- Objective is to **create and run Spark stored procedures in BigQuery** written in Python, Java, and Scala
- Apache Spark™ : **Multi-language engine** for executing data engineering, data science and machine learning on **single-node machines or clusters**.

- **Steps:**
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


  
