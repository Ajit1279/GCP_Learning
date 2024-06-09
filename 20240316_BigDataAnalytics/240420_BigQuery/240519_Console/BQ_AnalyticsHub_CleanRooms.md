- References: https://cloud.google.com/blog/products/data-analytics/introducing-bigquery-data-clean-rooms4

- **Introduction:**
  - Analytics Hub lets customers share and exchange data cost-effectively ande help to minimize data movement challenges.
  - However customers may require extra layers of protection if this data is subject to more stringent regulatory and privacy requirements.
  - Help large enterprises to understand audiences while respecting user privacy and data security.
  - E.g. Fraud detection by combining sensitive data from other financial / government agencies or build credit risk scoring by aggregating customer data across multiple banks.
  - **In Clean Rooms:**
    - **Data contributors publish tables or views**
    - **Aggregate, anonymize**, and help **protect sensitive** information.
    - **Configure analysis rules** to **restrict the types of queries** that can be run against the data.
    - It **does not** generally **require creating a copy or moving the data**; it remain under the **control of the data contributor**.
    - **Clean Room subscribers can perform privacy-centric queries** within their own project.
    - **Shared data** within a clean room can be **live and up-to-date**
    - **Contributors pay for the storage** of the data and **subscribers pay for the queries**.
         

- **Steps**
  - Go to BigQuery >> Analytics Hub >> Click on "Create Clean Room"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/892401a0-7ee0-423d-bb4a-1df41c75590b)

  - Fill-up the details in the form
    
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d631abbc-a5ef-44ba-a5a5-84530a6003ff)

  - Displays the message when it is created

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1fb0f547-5f1f-4872-94d5-d47dd445f502)

  - Click on the cleanroom name in Console. It provides other options

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/238b43f9-4517-4ff9-acf6-7a7bba13d25b)

  - Provide necessary details to create
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9551f696-68c1-4427-9bdb-73a3bcc289aa)

  - Configure Analysis Rules

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/50f99fd6-4b8c-4d88-b2a5-d67496c93071)

  - Review and click on "Add Data" to confirm

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1e54b0f7-26fb-4ee1-8d37-8586c68624a5)

  - Additional details / insights are available in other tabs

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/17a0a6cf-9c99-4eb8-b0a2-6004ea4bb64a)
    
