- References: https://cloud.google.com/bigquery/docs

- Basics:
  - Google Cloud's fully managed, petabyte-scale, and cost-effective analytics data warehouse
  - Lets you **run analytics** over **vast amounts of data** in **near real time**.
  - Key features of BigQuery's architecture is the **separation of storage and compute**, thus allowing them **to scale independently** 

- How does BigQuery Work?
  - **[Storage](https://cloud.google.com/bigquery/docs/storage_overview)**
    - Optimized for running analytic queries over large datasets.
    - Stores table data in **columnar format (each column separately)**.
    - Supports **high-throughput streaming ingestion and reads**
    - **Key Features:**
      - **Managed**: A completely google managesd service. You don't need to provision storage resources
      - **Durable**: 99.999999999% **(11 9's)** annual durability. Replicates data across multiple availability zones.
      - **Encrypted**: automatically encrypts all data before it is written to disk (uing your or google managed encryption key).
      - **Efficient:** Uses an efficient encoding format that is optimized for analytic workloads.
    - Majority of the data that you store in BigQuery is [table data](https://cloud.google.com/bigquery/docs/storage_overview#table_data):
      - [Standard tables](https://cloud.google.com/bigquery/docs/tables-intro#standard_tables):
      - [Table Clones](https://cloud.google.com/bigquery/docs/table-clones-intro)
      - [Table Snapshots](https://cloud.google.com/bigquery/docs/table-snapshots-intro)
      - [Materialized Views](https://cloud.google.com/bigquery/docs/materialized-views-intro)
      - [Temporary tables/ cached query results](https://cloud.google.com/bigquery/docs/cached-results)
      - [External Tables](https://cloud.google.com/bigquery/docs/external-tables)
    - [Metadata](https://cloud.google.com/bigquery/docs/storage_overview#metadata): Holds metadata about your BigQuery resources, not chareable.
    - [Read data from BigQuery storage using](https://cloud.google.com/bigquery/docs/storage_overview#reading_data): BigQuery API, BigQuery API Storage, Export, Copy
    - [Deletion](https://cloud.google.com/bigquery/docs/storage_overview#deletion): When you delete a table, the data persists for at least the duration of your time travel window.  

  - **[Analytics](https://cloud.google.com/bigquery/docs/query-overview)**
    - Adhoc analysis using [GoogleSQL](https://cloud.google.com/bigquery/docs/reference/standard-sql/migrating-from-legacy-sql)
    - [Geospatial analysis](https://cloud.google.com/bigquery/docs/geospatial-intro): Analyze and visualize geospatial data.
    - Machine Learning: Create and Execute Machine Learning models using [BigQuery ML](https://cloud.google.com/bigquery/docs/bqml-introduction)
    - Business Intelligence: Build rich, interactive dashboards and reports using [BigQuery BI Engine](https://cloud.google.com/bigquery/docs/bi-engine-intro)
    - [Query Jobs:](https://cloud.google.com/bigquery/docs/query-overview#query_jobs)
      - Actions that BigQuery runs on your behalf to load data, export data, query data, or copy data.
      - [Types of Queries:](https://cloud.google.com/bigquery/docs/query-overview#types_of_queries)
        - [Interactive Query Jobs:](https://cloud.google.com/bigquery/docs/running-queries#queries)
        - [Batch Query Jobs:](https://cloud.google.com/bigquery/docs/running-queries#batch)
    - Several [processes](https://cloud.google.com/bigquery/docs/query-overview#query_processing) occur when bigQuery runs a query: Execution Tree, Shuffle Tier, Query Plan, Query Monitoring & Dynamic Planning, Query Results
    - [Query Concurrancy and performance](https://cloud.google.com/bigquery/docs/query-overview#query_concurrency_and_performance): BigQuery runs many queries in parallel. As queries start and finish, BigQuery redistributes resources fairly between new and running queries.
    - [Query Optimization:](https://cloud.google.com/bigquery/docs/query-overview#query_optimization) The [query plan](https://cloud.google.com/bigquery/docs/query-insights) includes details about query stages and steps. These details can help you identify ways to improve [query performance](https://cloud.google.com/bigquery/docs/best-practices-performance-overview).
    - [Query Monitoring:](https://cloud.google.com/bigquery/docs/monitoring): BigQuery provides various metrics, logs, and metadata views to help you monitor your BigQuery usage
    - Query Pricing: Offers [On-demand pricing](https://cloud.google.com/bigquery/pricing#on_demand_pricing), [Capacity-based pricing](https://cloud.google.com/bigquery/pricing#capacity_compute_analysis_pricing)        
    - It lets you query data in various [data sources](https://cloud.google.com/bigquery/docs/query-overview#data_sources) like: BigQuery, External Data, Multi-cloud data, Public Datasets
    -  

  - Administration 

  - When you run a query:
    - **Query Engine** distributes the work in parallel across multiple workers
    - **Workers** scan the relevant tables in storage, process the query, and then gather the results.
    - **Petabit network** ensure that data moves extremely quickly to the worker nodes.  


- Hands-on:
  -     

- Create and use tables 
