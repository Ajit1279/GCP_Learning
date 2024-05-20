- References: https://cloud.google.com/bigquery/docs/notebooks-introduction

- Use notebooks to complete analysis and machine learning (ML) workflows by using SQL, Python, and other common packages and APIs.
- Share with specific users and groups by using Identity and Access Management (IAM).
- Notebook capabilities are available **only in the Google Cloud console**.
- Integrated with Pandas DataFrames, scikit-learn, Gemini Generative AI, SQL, matpolotlib, seaborn etc.
- BigQuery uses [Colab Enterprise runtimes](https://cloud.google.com/colab/docs/create-runtime) to run notebooks. 
  It's basically a virtual machine allocated to the user. It belongs to the same user and can not be shared
- Certain [permissions](https://cloud.google.com/bigquery/docs/create-notebooks#permissions_to_create_notebooks) are required to create notebook.

- Steps
  - Set the default region for code assets. It can not be changed.
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/144a173b-2df6-4b5a-b2ee-3f1f36363f21)

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b192c52d-5812-4c23-a602-cb6b4fa3776d)

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/de16ed7e-8208-48d7-b7ca-53a78c8c97bf)

  - Please note [VertexAI API](https://console.cloud.google.com/apis/api/aiplatform.googleapis.com/cost?project=mybqproj0427) needs to be enabled prior to executing it. Please note the related costs may not show-up immediately.
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e81421aa-a3d1-49bd-8786-20d5a92439ce)

  
  - Click on down arrow and then create Notebook option
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0eb68897-c3cc-4ac7-9c3d-833f023d9aeb)

  
  - Let's retry. It's taking longer as it's still allocating run time.
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c13c4d91-e433-44b7-8c9e-686e28ca2bd4)

    
  -    
