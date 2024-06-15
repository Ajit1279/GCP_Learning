- [Query a public dataset in BQ](https://cloud.google.com/bigquery/docs/quickstarts/query-public-dataset-bq)
  - [Examine a public dataset in in Google Cloud Console](https://cloud.google.com/bigquery/docs/quickstarts/query-public-dataset-console)
    - In the BigQuery >> Explorer >> Add section search **Public Datasets**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2475376f-ac1a-4cf3-a840-7b128d17a685)
    
    - One can select amongst Free and Paid Datasets. Browse and click on one of these datasets e.g. American Community Survey (bigquery-public-data.census_bureau_acs)
    - Click on **View Dataset**
    - The dataset appears in the BigQuery Explorer
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7a2809d9-0b4e-40e6-9b30-8f58df5a8eb2)

    - Query the dataset: **bq show bigquery-public-data:census_bureau_acs**    
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/bc57f032-2eed-4395-add5-49c0e6b0de83)

    - Run a Query:
      bq query --use_legacy_sql=false \
      'SELECT * FROM `bigquery-public-data.census_bureau_acs.blockgroup_2010_5yr` LIMIT 1000'

    - The data is not in readable format.Rather it's suggested to use Console to run the query 
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2eb49ebd-cead-4aa7-aceb-f2713b378f8a)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/44f9f4c9-739a-41fb-a959-819629e7971a)
 
  -  Many other similar queries can be run e.g.
     
      SELECT
        geo_id,
        SUM(income_30000_34999) AS total
      FROM
        `bigquery-public-data.census_bureau_acs.cbsa_2011_1yr`
      GROUP BY
        geo_id
      ORDER BY
        total DESC
      LIMIT
        100;

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5dc02834-c2be-405f-9085-5e57fbac4e3b)


- Please refer [Looker Studio Tutorial](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240519_Console/BQ_BIEngine_LookerStudio.md) for steps to copy public dataset in your own project dataset
