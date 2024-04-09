- Reference: https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-csv#python
  
- **Loading data from Cloud Storage to BigQuery:**
  - **i. Newly load data** in new table **ii. Append data** to existing table **iii. Overwrite (Truncate)** data in existing table
  - Data **once loaded** into BigQuery, it is **converted into** columnar format for **[Capacitor](https://cloud.google.com/blog/products/bigquery/inside-capacitor-bigquerys-next-generation-columnar-storage-format)** (columnar storage that supports semistructured data)
  - **Cloud Storage Limitations:**
    - The **dataset / table must be in the same regional or multi- regional location as the Cloud Storage bucket**   
    - **Data consistency not guaranteed for external data sources** (Changes to the underlying data while a query is running can result in unexpected behavior)
    - BigQuery **does not support** Cloud Storage object **versioning** (**Load job fails** if **generation number included** in cloud storage URI)
  - **CSV Limitation**
    - CSV **don't support nested or repeated data**.
    - Remove **Byte Order Mark (BOM)** characters (might cause unexpected issues).
    - Loading **compressed data is slower than loading uncompressed data** (BigQuery **cannot read** the data **in parallel** if you use **gzip compression**)
    - **Compressed and uncompressed** files **can not be included** in the **same load job**
    - The file **must meet load job limits (maximum size for a gzip file is 4 GB, max uncompressed file size 5 TB, max cell size 100MB, max Row size 100MB**)
    - Using **schema auto-detection does not automatically detect headers, flexible column names**
    - **Date, Timestamp** must be in specific format
  
- **Step-by-step instructions to load data using Python program**
  - **1. Grant required iAM roles:**
    - **BigQuery**
      - **Permissions: bigquery.tables.create, bigquery.tables.updateData, bigquery.tables.update, bigquery.jobs.create, bigquery.datasets.create**
      - **Roles:**
        - roles/bigquery.**dataEditor**
        - roles/bigquery.**dataOwner**
        - roles/**bigquery.admin** (includes the **bigquery.jobs.create** permission)
        - bigquery.**user** (includes the **bigquery.jobs.create** permission)
        - bigquery.**jobUser** (includes the **bigquery.jobs.create** permission) 
    - **Cloud Storage**:
      - **Permissions:** storage.buckets.get, storage.objects.get, storage.objects.list
      - **Roles:** roles/storage.admin  

  - **2. [Create a VM and set-up the Python environment.](https://github.com/Ajit1279/GCP_Learning/blob/main/Compute_VMs/20240407_Python/Python_Readme.md)**
    - **Run the below commands prior to executing:**
      **python -m pip install --upgrade pip**
      **pip install --upgrade google-cloud**
      **pip install --upgrade google-cloud-bigquery**
      **pip install --upgrade google-cloud-storage**

  - **3. Create a [main.py](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/20240325_BQ_DataLoad/20240406_CSVLoad_Python/main.py) to create a bigquery dataset and load data into it**:

  - **4. Once created it displays a message**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ae8c1b23-1fcf-41d6-8276-27ce5a2b0213)

  - **5. Verify in the table in Console: Bigquery >> BigQuery Studio >> bigdata0324 >> mybqdataset >> mybqtable1 >> preview**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ed4a69ff-c46c-4dc6-aa69-9eee7bcf9cd5)

  - **6. Clean-up**
    - Delete the bigquery dataset through console
    - exit from SSH session and delete the VM: **gcloud compute instances delete my-python-machine --zone=us-central1-a**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6ab06ef0-e9df-4281-91b5-ef83333b1f11)

  - sd
  - sd
  - sd  
- sd
- sd
- sd
- sd
- s
- ds
- ds
- d
- sd
- sd
- s
- ds
- ds
- d
- sd
- sd
- s
- ds
- ds
- ds
- d
- sd
- sd
- sd
- sd  
