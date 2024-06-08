- Reference: https://cloud.google.com/bigquery/docs/dts-introduction

- $${\color{red}You \space \color{red}will \space \color{red}need \space \color{red}Active \space \color{red}Google Ads \space \color{red}customer id \space }$$

- Basics:
  - Automates data movement into BigQuery on a scheduled, managed basis, without your team needing to write a single line of code.
  - Supports various cloud and non-cloud data sources
  - The data source data region and destination dataset region in BigQuery **are irrelevant** in most of the cases
  - **[Colocation is required]**(https://cloud.google.com/bigquery/docs/dts-locations#colocation_required) in cases of **Cloud Storage** and **Data Warehouse migrations** from Teradata (as it requires Cloud Storage in the middle)
  - Authentication and Authorization is required to your account / Service Account to enable data transfers
    - It operates at two different stages:
      - [Control Plane](https://cloud.google.com/bigquery/docs/dts-authentication-authorization#control_plane):
        - An authenticated user is **able to control and manage transfer configurations and runs**.
        - **bigquery.transfers.update** and **bigquery.transfers.get** permissions are required 
      - [Data Plane](https://cloud.google.com/bigquery/docs/dts-authentication-authorization#data_plane):
        - **Operate data transfers in an offline mode** and **trigger transfer runs** automatically based on a **user-specified schedule**.
  - **[There are transfer creator and transfer owners can be same or different](https://cloud.google.com/bigquery/docs/dts-authentication-authorization#transfer_creator_versus_transfer_owner)**


  - Let's now [create Google Ads Data Transfer](https://cloud.google.com/bigquery/docs/google-ads-transfer#setup-data-transfer)     
    - Click on Console >> BigQuery >> Data Transfers >> Click on "Create a Transfer"
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/55ebb8b9-b8ed-4e27-8eff-c4a69691a4e6)

    - Provide various details like Source (Google Ads), Transfer Config Name, destination Dataset id, Repeat Frequency etc.
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/59359885-67a1-41f8-b6e8-315123b56055)
  
    - It asks for credentials after you click on "save"

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/88bc9e9e-b00e-4def-bd88-de39d1fadf76)
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0e2e11b3-c036-40a3-8c05-819b0d48dca0)


    - It creates schedules automatically
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/bb7db9d2-7700-4fa3-b474-5c1beedb56c3)

    - It shows the jobs failed
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d33718b5-b77e-42ce-a148-5c94d8f9f135)

    - Let's toubleshoot in [Google Ads Transfer issues](https://cloud.google.com/bigquery/docs/transfer-troubleshooting#ads-transfer). No specific steps found
      
    - So created the service account bqdatatransfer, granted bigquery data transfer service agent permission and edited configs to transfer using this service account. No luck! 
