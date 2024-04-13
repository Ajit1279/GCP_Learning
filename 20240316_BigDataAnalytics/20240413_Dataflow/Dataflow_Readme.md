- Reference: https://cloud.google.com/dataflow/docs/overview
- **Basics:**
  - Provides **unified stream and batch data processing** at scale with low latency
  - **Create data pipelines** that read from **one or more sources**, **transform** the data, and **write** the data to a **destination**.
  - **Same programming model for both batch and stream analytics.**
  - Supports [two modes for streaming jobs](https://cloud.google.com/dataflow/docs/guides/streaming-modes):
    - **[exactly-once processing](https://cloud.google.com/dataflow/docs/concepts/exactly-once) of every record.**
    - At-least-once mode
   
- **Advantages:**
  - **Managed service:** Google manages all of the resources needed to run Dataflow (**VMs** to **execute pipelines** are **automatically allocated and deleted** when job is complete or cancelled)
  - **Scalable**
  - 



  - **Typical use cases**:
    -  **Ingesting / replicating data** across subsystems
    -  **Create [ETL](https://cloud.google.com/learn/what-is-etl) workflows** (e.g. to [ingest data into datawareshouse such as BigQuery](https://github.com/Ajit1279/GCP_Learning/tree/main/20240316_BigDataAnalytics/20240318_ETL_intoBigquery_usingDataFlow))
    -  Powering BI Dashboards
    -  Applying ML in real time to streaming data.
    -  Processing sensor data or log data at scale.

- 
- sd
- sd
- sd
- sd
- [Step-by-step-instructions](https://cloud.google.com/dataflow/docs/quickstarts/create-pipeline-python):
  - Learn how to use the Apache Beam SDK for Python to build a program that defines a pipeline.
  - Then, you run the pipeline by using a direct local runner or a cloud-based runner such as Dataflow. 
- sd
- s
- ds
- ds
- ds
- ds
 
