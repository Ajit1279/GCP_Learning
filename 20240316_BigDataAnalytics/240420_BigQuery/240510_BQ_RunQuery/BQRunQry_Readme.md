- Reference: https://cloud.google.com/bigquery/docs/running-queries
# Run a Query #
- In BigQuery, you can run two types of queries:
  - **Interactive** query jobs: Jobs which Bigquery runs **on demand** (by default)
  - **Batch** query jobs: BigQuery waits until **compute resources are available** 
- The results are stored in temporary table (default), permanent tables (new or existing).
- **Run an interactive query (bq)**
  - Activate Cloud Shell
  - Paste the query in the Cloud Shell and hit enter:
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/3f8dc580-03a8-4c98-b32d-341a64039130)

  - The result is displayed as shown below:
  ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6a56408f-d59f-49b0-9cad-58e37f8dab7f)

  - You can specify the destination table and location for the query results. In this example, the usa_names dataset is stored in the US multi-region location. You cannot query a dataset in one location and write the results to a table in another location.

  - Let's try the query below:
    bq query \
    --location=ASIA \
    --destination_table=mybqproj0427.testdata.query_result \
    --use_legacy_sql=false \
    'SELECT       
       name, gender,      
       SUM(number) AS total 
     FROM       
       `bigquery-public-data.usa_names.usa_1910_2013`     
     GROUP BY
       name, gender
     ORDER BY
       total DESC
     LIMIT 10;'
    
  - It gives an error: BigQuery error in query operation: Location ASIA does not support this operation.
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/94dee83a-4f34-4af9-9871-8b759bdf2326)

  - Rerun by changing the location to US:
    bq query \
    --location=US \
    --destination_table=mybqproj0427.testdata_01.query_result \
    --use_legacy_sql=false \
    'SELECT name, gender, SUM(number) AS total 
     FROM       
       `bigquery-public-data.usa_names.usa_1910_2013`     
     GROUP BY
       name, gender
     ORDER BY
       total DESC
     LIMIT 10;'

  - It gave an error: Invalid dataset ID "mybqproj0427.testdata_01". Dataset IDs must be alphanumeric (plus underscores) and must be at most 1024 characters long. 

  - dsd

  - sd  
- **Run an interactive query (Python)** 
