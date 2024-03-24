- Reference: https://cloud.google.com/architecture/performing-etl-from-relational-database-into-bigquery

- **Objective:**
  - Demonstrates how to use Dataflow to extract, transform, and load (ETL) data from an online transaction processing (OLTP) relational database into BigQuery for analysis, by taking advantage of the analytical query capabilities of BigQuery and the batch processing capabilities of Dataflow.
  - **Two approaches:**
    - **Using BigQuery to load and transform the data:**:
      - To perform a one-time load of a small amount of data into BigQuery for analysis  OR
      - To prototype your dataset before you automate larger or multiple datasets.
    - **Using Dataflow to load, transform, and cleanse the data.**
      - To load a larger amount of data   OR
      - Load data from multiple data sources  OR
      - To load data incrementally or automatically.  

- **OLTP (Online Transaction Processing Databases)**
  - Optimized for transactions
  - ACID properties: Atomicity, Consistency, Isolation, Durability
  - Highly normalized schema

- **OLAP (Online Analytical Processing Databases)**
  - Optimized for data retrieval and analysis
  - Denormalized schemas 

- **Step-by-step instructions:**
  - Enable the Compute Engine and Dataflow APIs

  - JSON snapshots of tables in the [MusicBrainz database](https://musicbrainz.org/doc/MusicBrainz_Database), which is built on PostgreSQL and contains information about all of the MusicBrainz music.
  - The MusicBrainz schema includes **three tables:**
    - **artist**
    - **recording**
    - **artist_credit_name:** Represents credit given to the artist for a recording, and the artist_credit_name rows link the recording with its corresponding artist through the artist_credit value.

  - **Approach1: ETL with BigQuery**
    - Open BigQuery and click on **create dataset** in front of project name
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/908da028-ea4b-4be6-9d46-0bd9edd8804c)

    - Input Dataset Id as "musicbrainz" and dataset location as "Multi Region US" and click on create
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f9ca3b3f-db3c-4c4d-bb40-860100d557a1)

    - Click on three dots, then "Create Table"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ccc85ba1-b54d-466f-92c7-27aa63eb86fe)

    - Input the values as shown below. In Schema field, input content from [artist_schema](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/20240318_ETL_intoBigquery_usingDataFlow/artist_schema.json) file
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7961d1dd-48c8-48f9-ba7c-e7cc6b43db0c)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/cf7d4807-677e-4b84-8514-303510275b75)

    - The new table appears under dataset aftet the load job is complete in few seconds. 
    - Similarly create artist_credit_name table using [artist_credit_name schema](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/20240318_ETL_intoBigquery_usingDataFlow/artist_credit_name_schema.json)
    - Create recording table using [recording schema](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/20240318_ETL_intoBigquery_usingDataFlow/recording_schema.json)
    - All three tables are created as shown below:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/389c2b41-77b1-4e2c-ae98-b115f6453d3e)

    - Manually denormalize the data
      - In the query editor, copy the content from [SQL Query](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/20240318_ETL_intoBigquery_usingDataFlow/SQLQuery.sql) 

      - Select following values in **More >> Query Settings**  and **click Run**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1b89ede0-583d-4456-b72e-ad2e302bdc0f)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8a0f1165-abf5-4659-b927-c03b4f40641c)
  
 
  - The result is shown in "Query Results" pane and a new table "recordings_by_artists_manual" is shown in left pane.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/bae38b71-fd3f-40e1-b894-422e36613a7d)

  - [**Approach2 (ETL into BigQuery with Dataflow)**](https://cloud.google.com/architecture/performing-etl-from-relational-database-into-bigquery#approach_2_etl_into_bigquery_with_cloud_dataflow)
    - **Data loaded into BigQuery using a program and Dataflow pipeline (instead of BigQuery UI)**
    - **Then Beam programming model to denormalize and cleanse data to load into BigQuery.**
    - **Use Dataflow for ETL (instead of the BigQuery UI) when:**
      - You are performing **massive joins** from around 500-5000 columns of more than 10 TB of data
      - You want to **clean or transform your data as it's loaded** into BigQuery, instead of storing it and joining afterwards.
      - You **plan to do custom data cleansing** (which cannot be simply achieved with SQL).
      - You plan to **combine the data, such as logs or remotely accessed data, during the loading** process (which is outside of the OLTP).
      - You plan to **automate testing and deployment of data-loading logic using CI/CD**
      - You **anticipate gradual iteration, enhancement, and improvement of the ETL process** over time.
      - You **plan to add data incrementally, as opposed to one-time ETL**.
    - sd
    - s
    - ds
    - ds
    - ds
    - d
    - sd
    - sd
    - sd
    - sd
    -  
