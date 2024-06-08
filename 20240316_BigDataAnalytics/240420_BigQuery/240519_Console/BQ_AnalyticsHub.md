- Reference: https://cloud.google.com/bigquery/docs/analytics-hub-introduction

- **Introduction:**
  
  - **Data Exchange Platform** to **share data and insights at scale** across organizational boundaries
  - You can:
    - **Browse** through the **datasets** that you have access to **in Analytics Hub**
    - **Create data exchanges for data sharing** 
    - **Augment your analytics and ML initiatives with third-party and Google datasets.**
    - **Monetize data** by **sharing** it with your **partners or within organization** in **real time**
    - **Discover the data** that you are looking for, **combine** shared **data** with your **existing data**
  - Also has robust security and data privacy framework. [**Data egress options**](https://cloud.google.com/bigquery/docs/analytics-hub-introduction#data_egress) to **restrict the export by subscribers** of data out of BigQuery linked datasets.
  - Refer the [**Architecture**](https://cloud.google.com/bigquery/docs/analytics-hub-introduction#architecture) for details
  - [**Example Use Case**](https://cloud.google.com/bigquery/docs/analytics-hub-introduction#example_use_case)
  - 

  - **Shared Datasets:**
    - Unit of data sharing in Analytics Hub.
    - Supports Authorised views, Authorised Datasets, BigQuery ML models, External Tables, Matarialised views, Tables, Views, Table Snapshots etc

  - **[Data Exchanges](https://cloud.google.com/bigquery/docs/analytics-hub-manage-exchanges)**
    - **Container** that **enables** self-service **data sharing**.
    - **Administrators** can **grant access to subscribers** at the **exchange** and the **listing level** to **avoid granting access to datasets explicitly**.
    - Data Exchanges can be private or public
    - Admins can **create and manage multiple Data Exchanges in Analytics Hub**
    - Refer steps to create [here](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240519_Console/BQ_CreateExchange.md)

  - **[Listings](https://cloud.google.com/bigquery/docs/analytics-hub-manage-listings)**
    - **Reference to a shared dataset** that a publisher lists **in a data exchange**.
    - Specify the **dataset description**, **sample queries** to run on the dataset, links to any **relevant documentation**, and any additional **information for subscribers** to **use dataset**.
    - Like Data Exchanges it can be public or private
    - Refer the steps [here](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240519_Console/BQ_AnalyticsHubListing.md)

  - **[Linked Datasets](https://cloud.google.com/bigquery/docs/analytics-hub-view-subscribe-listings)**
    - **Subscribing to a listing creates a linked dataset in your project** and **not a copy** of the dataset
    - Thus these are **Read-only BigQuery dataset** that **serves as a link to a shared dataset**.        


  - **[Limitations](https://cloud.google.com/bigquery/docs/analytics-hub-introduction#limitations)**
    - Max 1000 linked datasets
    - A dataset with **unsupported resources cannot be selected** as a shared dataset
    - Linked datasets **created before July 25, 2023 are not backfilled**
    - Shared datasets are indexed in [Data Catalog](https://cloud.google.com/data-catalog/docs/concepts/overview). For **datasets with hundreds of subscribers**, **updates might take up to 18 hours** to **get indexed** in Data Catalog.
    - Taking **snapshots of linked dataset tables** is **not supported**.
    - Queries with **linked datasets and JOIN statements** that are **larger than 1 TB might fail**. 

