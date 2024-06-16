- References: https://cloud.google.com/bigquery/docs/routines

- Resource type that includes the Stored Procedures, User Defined Functions (UDFs), Remote Functions, Table Functions

- **Stored Procedures:**
  - Collection of statements that can be called from other queries or other stored procedures.
  - Take input arguments and return values as output.
  - You name and store a procedure in a BigQuery dataset.
  - There are few stored procedures in-built within BigQuery. These are called [System Procedures](https://cloud.google.com/bigquery/docs/reference/system-procedures)
  - Following steps are involved. Refer [sample](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240427_CreateRoutines/createcust.sql) for details
    - Create a stored proc using CREATE PROCEDURE statement
    - Body of the procedure appears between BEGIN and END statements
    - The multi-statement query sets a variable, runs an INSERT statement, and displays the result as a formatted text string.
    - A procedure can have:
      - **Input parameter:** Allows input for a procedure, but does not allow output (e.g. name in the sample)
      - **Output parameter:** To create an output parameter, use the **OUT keyword** before the name of the parameter. you must use a variable to receive the output value: e.g. SELECT * FROM mydataset.customers
WHERE customer_id = id;
      - **Input / Output parameter:** Accepts input for the procedure and also returns a value from the procedure. Use INOUT keyword
    - You can authorize stored procedures as [Authorized routines](https://cloud.google.com/bigquery/docs/authorized-routines) It lets you share query results with specific users or groups without giving them access to the underlying tables that generated the results.
    - You can create, drop, and manipulate tables, as well as invoke other stored procedures on the underlying table.
    - To call the procedure, use the CALL statement: CALL mydataset.create_customer(); 
    - To call system procedure qualify it with BQ e.g. CALL BQ.REFRESH_MATERIALIZED_VIEW;
    - Please refer this [PySpark tutorial](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240519_Console/Error_BQ_PySpark_Readme.md) for implementation details.

- [**User Defined Functions (UDFs):**](https://cloud.google.com/bigquery/docs/user-defined-functions)
  - Lets you create a function by using a SQL expression or JavaScript code.
  - It can be either:
    - **Persistent:** Reuse across multiple queries. You must specify a dataset for the function
    - **Temporary:** Only exist in the scope of a single query.
  - Accepts columns of input, performs actions on the input, and returns the result of those actions as a value.
  - Steps:
    - To create use CREATE FUNCTION or CREATE TEMP FUNCTION statements
    - Any reference to BQ objects (e.g. tables, views etc.) must include project id, if UDF is to be called in other project. 
    - **Error at call time** if the **type of the argument** passed is **incompatible** with **function definition**
    - Use the UDF within the SELECT statement
    - **Templated SQL UDF parameters** can be specified with type equal to **ANY TYPE**. It **cannot be used** for the **function output**  
    - To delete persistent UDF use DROP FUNCTION.
    - Temporary UDF expires as soon as the query finishes. The DROP FUNCTION statement is only supported for temporary UDFs in multi-statement queries and procedures.
    - [Javascript UDFs](https://cloud.google.com/bigquery/docs/user-defined-functions#javascript-udf-structure) lets you call SQL query from Javascript, but it typically **consume more slot resources** as **compared to standard SQL** queries, **decreasing** job **performance**.
  - Refer [sample](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240427_CreateRoutines/UDF_Sample.sql) for more details. 
  - **Community contributed UDFs** are available in **bigquery-public-data.persistent_udfs public dataset** and and the open source [bigquery-utils GitHub repository](https://github.com/GoogleCloudPlatform/bigquery-utils)
  - You can see all the community UDFs in the Google Cloud console by starring the bigquery-public-data project in the Explorer pane, and then expanding the nested **persistent_udfs dataset** within that project.

  
