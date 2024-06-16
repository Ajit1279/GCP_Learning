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
    - You can authorize stored procedures as [Authorized routines](https://cloud.google.com/bigquery/docs/authorized-routines)
    - Lets you share query results with specific users or groups without giving them access to the underlying tables that generated the results.
    - You can create, drop, and manipulate tables, as well as invoke other stored procedures on the underlying table.
    - To call the procedure, use the CALL statement: CALL mydataset.create_customer(); 
    - To call system procedure qualify it with BQ e.g. CALL BQ.REFRESH_MATERIALIZED_VIEW;
    - Please refer this [PySpark tutorial](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240519_Console/Error_BQ_PySpark_Readme.md) for details.    
