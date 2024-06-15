- References: https://cloud.google.com/bigquery/docs/bi-engine-looker-studio

- Lets you perform fast, low-latency analysis services and interactive analytics with reports and dashboards that are backed by BigQuery.
- Objective
  - Create a BI Engine capacity reservation by using BigQuery in the Google Cloud console 
  - Use Looker Studio to connect to a BigQuery table managed by BI Engine. 
  - Create a Looker Studio dashboard that queries your BI Engine-managed table.
  - Please note you will incur costs for BI Engine reservation and BigQuery Storage Costs
 


- **Steps**
 - Create a BigQuery Dataset

   ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5b817fcd-1ffd-4e41-8a0c-9e11dbbc5f40)

  
 - Create a table by copying data from a public dataset
   - In the navigation tab, click Add then "Public Dataset" and search "san_francisco_311"

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e0dc988f-2bb5-4eff-b0e4-4b3ff8dc06e8)

   - Once added, click on "Copy"

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/804ef026-13a1-4765-8373-5a483b8fa0b8)

   - Click on "Create New Dataset" to select your Destination project and dataset

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/58a63f66-520c-49fc-9adc-bb58cad03270)

   - Click on change the project id

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/60dd7cf3-b242-41ee-83af-50be4575df79)

   - Enter the other details like dataset id, region, Table Expiration (to save costs) and click on "Create Dataset"

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b305c1f8-0aaa-4666-9dbf-a6b4bfdbfefc)

   - Click on Copy, it will display new window, Click on "Allow"

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/72fdb5bb-dc14-4a59-ba28-00370e3a1c7c)

   - It displays message (Copy Dataset was scheduled successfully). Click on View Details

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0ed01233-73c5-41ac-97e4-439eed382807)


   - You can wait for the scheduled query to run or click "Run Transfer Now"

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b52ca321-3a08-40ba-b7e3-df46df2e2807)


   - In the next window select appropriate options and then click "OK". It displays the message

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c6a17026-d0f9-4b1b-8f3a-fb3832bef68b)


   - In the explorer expand the dataset name. It displays the copied table name. Click on it to view details

     ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/673695a4-6c0a-4edd-9207-a62153ee4e75)


- Create BI Engine Reservation
  - Go to Bigquery >> Administration >> BI Engine and click on "Create Reservation". Enter details

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0b76f6e3-7db8-4642-907f-52c30d675d94)


  - In Preferred tables option, select table name and lick create.

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fa700fcb-5b8e-48f8-9b14-d5f153ad342f)


  - Reservation is created

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1df01ca1-2526-4b36-be1f-4ec8051611b1)

- Create a data source connection in Looker Studio
  - Before you create a report in Looker Studio, you must create a data source for the report.
  - A report may contain one or more data sources
  - When you define your data source connection in Looker Studio, BI Engine uses the table and columns you configure to determine what data to cache.
  - Please check the [required permissions](https://cloud.google.com/bigquery/docs/bi-engine-looker-studio#required_permissions)
  - Steps
    - Open [Looker Studio](https://lookerstudio.google.com/navigation/reporting)

    - Click on "Blank Report" and set-up account
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2c1b1c6d-985b-4e87-b05d-381073244462)

    - In the Data Sources, click on "Create new Data Sources"
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9a046bfd-f8de-43ab-a16d-77e41ce3d926)

    - Select BigQuery in Google Connectors and click on "Authorize"
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/be78c40f-5f90-48ba-ac21-d8e670f43f10)

    - Select project, Dataset and Table

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5d06eb42-9af2-4061-8df0-2f93e95d8511)

    - Click on "Create Report", when prompted click "Add to report"
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8677d176-2bd4-42e8-aa31-4a79bfb0702a)

  - Create Visualization
    - Once you have added the data source to the report, the next step is to create a visualization.

    - Change the report name
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/132a64e3-f2cf-4379-8873-b805fdab75a7)

    - To customize, click on the report and drag required fields
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/df09d395-87b8-4d3f-a19b-90078ed13c65)

    - Click on "View" and it will display the report. This is simplest report
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8b3171e6-1c53-4145-b05b-ae77a439b82e)

    - It can be edited to customize again and the link can be shared

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/aafc77ff-c187-4701-b7ca-d15436aeace5)

- Clean-up
  - Delete the dataset, Reservations, Data Transfers, Newly Created Looker Report
