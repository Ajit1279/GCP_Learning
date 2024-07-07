- Various templates can be selected

- WordCount 

- YAML:
  - https://cloud.google.com/sdk/gcloud/reference/dataflow/yaml
  - https://beam.apache.org/documentation/sdks/yaml/
  - https://github.com/apache/beam/tree/master/sdks/python/apache_beam/yaml/examples  

- Streams
  - Change **Bigtable streams** to:
    - HBase Replicator
    - Vector Search
    - BigQuery
    - Pubsub
    - Cloud Storage

  - Change **Spanner Streams** to
    - BigQuery
    - Cloud Storage
    - Pub/ Sub

  - Storage Text to:
    - BigQuery
    - Bigquery with Python UDF
    - Data Masking / Tokenization to BigQuery with BQ Storage Write API

  - Datastream to:
    - BigQuery
    - Cloud Spanner
    - SQL

  - JMS to Pubsub

  - Kafka to
    - BigQuery
    - Cloud Storage
    - Kafka

  - Pub/Sub
    - Pub/Sub Avro to BigQuery
    - Pub/Sub Proto to BigQuery (also using using Python UDF) 
    - Pub/Sub Subscription to Cloud Storage
    - Pub/Sub Subscription to BigQuery
    - Datadog
    - Elasticsearch (also using Python UDF)
    - JDBC
    - MongoDB (also with Python UDF)
    - Redis
    - Splunk

- Bulk Data Processing / Batch Jobs
  - Astra DB to BigQuery

  - Avro Files
    - Big Table
    - Cloud Spanner

  - BigQuery
    - Paraquet
    - Bigtable
    - Elasticsearch (also with Python UDF)
    - MongoDB
    - Tensorflow records

  - CSV to BigQuery

  - Cassandra to Bigtable

  - Bigtable to
    - Avro files in Cloud Storage
    - JSON
    - Paraquet files on Cloud Storage
    - SequenceFile on Cloud Storage
    - Vector Embeddings

  - Cloud Spanner to:
    - Avro files on Cloud Storage
    - Text File on Cloud Storage
    - Vertex Vector Search

  - Cloud Storage:
    - Text files to Pub/Sub
    - Elasticsearch (also using Python UDF)

  - Dataplex
    - JDBC Ingestion
    - Convert Cloud Storage File format
    - Tier data from BigQuery to Cloud Storage

  - Firestore to text files on Cloud Storage

  - Google Cloud to Neo4j

  - JDBC to:
    - BigQuery (Legacy or with storage API support)
    - Pub / Sub
   
  - MongoDB / MySQL / Oracle / PostgreSQL / SQL Server / Spanner / Text Files on Cloud Storage to BigQuery

  - Paraquet files / SequenceFiles to Cloud Bigtable
 
  - Text files to:
    - BigQuery (using Storage API and Python UDF)
    - Cloud Spanner
    - Firestore (Datastore Mode)
   
- Utilities
  - Bulk Compress / Decompress files on Cloud Storage
  - Bullk delete entities in Firestore
  - Convert file formats between Avro, Paraquet & CSV
  - Streaming Data Generator
