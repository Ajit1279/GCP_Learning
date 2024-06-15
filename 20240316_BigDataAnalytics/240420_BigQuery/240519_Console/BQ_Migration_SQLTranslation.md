- References: https://cloud.google.com/bigquery/docs/interactive-sql-translator#translate_a_query_into_standard_sql

- To translate a query from a different SQL dialect into a GoogleSQL
- Reduce time and effort when you migrate workloads to BigQuery
- Supported SQL dialects: Amazon Redshift SQL, Apache HiveQL / Beeline CLI, Basic Terradata Query, IBM DB2 SQL, PostgreSQL SQL etc.


- **Steps:**
  - Enable BigQuery Migration API (If not activated already)

  - Create two buckets - one each as source and target - otherwise there's an error message.

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4c92403c-96b3-4964-ab47-d0d57840db87)


    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a1182956-0061-4742-89f0-0a396c883724)

    
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/287eb078-d082-4f4b-815c-12b67c5005ee)


  - Create a file Teradata.sql with sample query and upload it to the bucket:

    CREATE VOLATILE TABLE exampleTable (age INT, gender VARCHAR(10));
    
    INS INTO exampleTable (10, 'F');

    INS INTO exampleTable (20, 'M');

    SEL *

    FROM exampleTable

    WHERE gender EQ 'F'

    AND age LT 15; 


  - Go to BigQuery >> Migration >> SQL Translation in Console

  - Click on "Start Translation"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/12130b05-4d0e-4b5f-b4d4-7c6ebad07ef3)


    

    
     

    

  - 
 
  -  

- 
