- **Reference:** https://cloud.google.com/dataflow/docs/overview

- **Basics:**
  - Built on open source [Apache Beam](https://beam.apache.org/) project.

  - Provides **unified stream and batch data processing** at scale with low latency

  - **Create data pipelines** that read from **one or more sources**, **transform** the data, and **write** the data to a **destination**.

  - **Same programming model for both batch and stream analytics.**

  - Supports [two modes for streaming jobs](https://cloud.google.com/dataflow/docs/guides/streaming-modes):
    - **[exactly-once processing](https://cloud.google.com/dataflow/docs/concepts/exactly-once) of every record.**
    - **At-least-once** mode

- **[How it works](https://cloud.google.com/dataflow/docs/overview#how_it_works)**
  - Uses a **data pipeline model**, where data moves through a **series of stages**.
    - Reading data from source
    - Transofrming & aggregating data
    - Writing results to destination 

  - **[Runner]**(https://beam.apache.org/documentation/basics/#runner) speicifies _how_ the pipeline is executed i.e. run an Apache Beam pipeline on a specific platform e.g. **Dataflow runner**
    - Uploads executable code and dependencies to cloud storage bucket
    - Create Dataflow job
    - Dataflow job allocates pool of VMs to execute pipeline
    - A typical ETL and BI solution using Dataflow
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8309b8b0-69db-4c45-92df-78dd456534e9)

 
- **Advantages:**
  - **Managed service:** Google manages all of the resources needed to run Dataflow (**VMs** to **execute pipelines** are **automatically allocated and deleted** when job is complete or cancelled)

  - **Scalable**: Support pipelines **at large scale** as Data is processed in **parallel** ([dynamically rebalance work among the VMs](https://cloud.google.com/dataflow/docs/dynamic-work-rebalancing))

  - **Portable:**
    - Apache Beam supports Java, Python, and Go SDKs, as well as [multi-language pipelines](https://beam.apache.org/documentation/programming-guide/#multi-language-pipelines) For example, the **[Apache Kafka connector](https://github.com/apache/beam/blob/master/sdks/python/apache_beam/io/kafka.py)** and **[SQL transform](https://github.com/apache/beam/blob/master/sdks/python/apache_beam/transforms/sql.py)** from the Java SDK can be used in Python pipelines.
    - Dataflow executes Apache Beam pipelines. You can run pipeline on a different platform (**Apache Flink or Apache Spark**) without rewriting the pipeline code.  

  - **Flexible**:
    - Can be used for simple pipelines (moving data) or advanced applications (realtime streaming analytics).
    - Developer can create a [template](https://cloud.google.com/dataflow/docs/concepts/dataflow-templates) and data scientist can deploy it on demand or use [Jupyter notebooks](https://cloud.google.com/dataflow/docs/guides/interactive-pipeline-development) to run pipelines iteratively.

  - **Observable**: Monitor the status of your Dataflow jobs through the [Dataflow monitoring interface](https://cloud.google.com/dataflow/docs/guides/monitoring-overview) using a graphical representation. 


- **Typical use cases**:
  -  **Ingesting / replicating data** across subsystems
  -  **Create [ETL](https://cloud.google.com/learn/what-is-etl) workflows** (e.g. to [ingest data into datawareshouse such as BigQuery](https://github.com/Ajit1279/GCP_Learning/tree/main/20240316_BigDataAnalytics/20240318_ETL_intoBigquery_usingDataFlow))
  -  Powering BI Dashboards
  -  Applying ML in real time to streaming data.
  -  Processing sensor data or log data at scale.

- [Step-by-step-instructions to Create Dataflow pipeline using Python](https://cloud.google.com/dataflow/docs/quickstarts/create-pipeline-python):
  - Learn how to use the Apache Beam SDK for Python to build a program that defines a pipeline.
  - Then, you run the pipeline by using a direct local runner or a cloud-based runner such as Dataflow. 
- sd
- s
- ds
- ds
- ds
- ds
 
