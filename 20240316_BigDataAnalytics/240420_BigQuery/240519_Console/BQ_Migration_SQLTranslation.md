- References: https://cloud.google.com/bigquery/docs/interactive-sql-translator#translate_a_query_into_standard_sql

- To translate a query from a different SQL dialect into a GoogleSQL
- Reduce time and effort when you migrate workloads to BigQuery
- Supported SQL dialects: Amazon Redshift SQL, Apache HiveQL / Beeline CLI, Basic Terradata Query, IBM DB2 SQL, PostgreSQL SQL etc.


- **Steps:**
  - Enable BigQuery Migration API (If not activated already)

  - Create a bucket. We'll use this bucket to save SQL query, which needs to be translated

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/20a502fd-71da-42b4-bc00-a3d186fc7326)

  - Create a file with sample query:

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

  - Enter details for "Translation Configuration"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0cbd1eb7-d86f-4b41-99b9-70b17e5171b5)
     

    

  - 
 
  -  

- 
