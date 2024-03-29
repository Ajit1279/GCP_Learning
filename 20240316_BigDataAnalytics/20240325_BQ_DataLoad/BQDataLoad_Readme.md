- Reference: https://cloud.google.com/bigquery/docs/loading-data

- There are several ways to ingest data into BigQuery:
  - **Batch load** a set of data records. **Can be one time or recurring**
    - **Load Jobs**:
      - Load data **from Cloud Storage** or **from a local file (in Avro, CSV, JSON, ORC, or Parquet format)** by creating a load job
      - Require **staging the data to intermediate storage** (e.g. Cloud Storage).
      - **Most suitable for file-based patterns** 

    - **SQL** : **LOAD DATA SQL statement** to load Avro, CSV, JSON, ORC, or Parquet files.

    - **BigQuery Data Transfer Service** : Automate loading data **from Google Software as a Service (SaaS) apps or from third-party applications** and services.

    - **BigQuery Storage Write API**: **batch-process an arbitrarily large number of records** and **retry if single atomic operation fails**.

    - **Other managed services**: Import the **data extracted from external data store** into BigQuery (e.g. load data from Firestore exports).

  - **[Stream](https://cloud.google.com/bigquery/docs/loading-data#streaming) individual records** or smaller batches of records.
    - **Storage Write API**: The Storage Write API supports **high-throughput streaming ingestion** with exactly-once delivery semantics.

    - **DataFlow:**  Set up a **streaming pipeline** using **Dataflow with the Apache Beam SDK**

    - **[DataStream](https://cloud.google.com/datastream-for-bigquery?hl=en)** to **replicate data and schema updates from operational databases** directly into BigQuery.

    - **BigQuery Connector for SAP**: Near real time replication of SAP data

    - **Pub/sub:**: **To coordinate streaming analytics and data integration pipelines**  

  - Use **queries to generate new data** and append or **overwrite the results to a table**.
  - Use a **third-party application** or service.

-  
