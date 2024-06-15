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


  - Create a file Teradata.sql with sample query and upload it to the source bucket:

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


  - Enter the Translation Configuration
 
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/3f398c7d-ed0a-4326-8cad-4f34ac97924b)


  - In source details, enter the source bucket name

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d826b089-f3c4-449d-83b4-846c332c28b5)

  - In target, enter the destination bucket name

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/52cd8e3b-5d54-4558-9847-f92780b2f0d2)


  - Click on "create". It's displayed

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/372d2595-5f1c-4802-b507-253413a907a4)


  - Click on the translator name to view the results:

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/dcf6b53d-6dc3-45fb-8ebe-00dda4aa3a0b)
  

  - Go to the destination folder

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e5b67a78-d353-4a68-94ee-4e123d344707)

  - Click on the "teradata" file name url

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f38568d9-52e0-47c2-87fe-fe607b35e472)


  - It displays the "translated query"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5169bb70-b02d-44f1-836a-96723e64557b)


  - Click on "Open interactive Translation"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0c37c480-daed-4b1e-b85e-7a7e2f91a623)


  - It displays a message in the next window. Click "confirm" to continue

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/96ef2adb-023b-475c-8fd5-0d58468d3035)


  - Enter the query to be translated in the left panel and click "Translate"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e2a9dc7c-0ce5-44a7-b5c5-9a5854122478)

    
  - The translated query is displayed in the right hand side panel. Click Run or Save as appropriate

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a419b855-2e70-4e35-9246-96baf5c18113)
 
 
  - The results are displayed in the bottom pane

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c99d2c1e-ae69-467b-89d3-4e515322798f)

  - Click on results to display results

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2ecfeda1-c297-4c10-a9c0-70489388b2c9)


- 
