- [Step-by-step-instructions to Create Dataflow pipeline using Python](https://cloud.google.com/dataflow/docs/quickstarts/create-pipeline-python):
  - Learn how to use the Apache Beam SDK for Python to build a program that defines a pipeline.
  - Then, you run the pipeline by using a direct local runner or a cloud-based runner such as Dataflow.
  - Create a new project (i.e. dataflowpoc) to ensure you have required permissions and easy clean-up
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/60a155e8-7080-48b7-bb89-1b3e249d2d4a)

  - **Enable various APIs** listed below:
    - Dataflow API
    - Compute Engine API
    - Cloud Logging API
    - Cloud Storage
    - Google Cloud Storage JSON API
    - BigQuery API
    - Cloud Pub/Sub API
    - Cloud Datastore API
    - Cloud Resource Manager API

  - Once the APIs are enabled, assign below roles to the **Compute Engine Default service Account: Cloud Storage Admin, Dataflow Admin, DataFlow Worker** 
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f9ec1676-4f5b-4aaa-b5f3-49cf4add7d5a)

  - Activate the cloud shell, **create a python virtual environment** and activate it by running below commands:
    **pip3 install virtualenv**
    **python3 -m virtualenv env**
    **source env/bin/activate**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/95ce8ac6-091c-4322-94c3-0be02d0b9fc4)

  - **Install the Apache Beam SDK**: **pip3 install apache-beam[gcp]**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fc6a8dec-ed59-4fae-ad8a-7bd50fc83dc0)

  - **Set up a Cloud Storage bucket for output data**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/867bc1c0-09bb-4783-8c33-5b4e1a8dd5a5)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a5d3d719-a42b-4ddd-97d7-450430e2f9a2)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a1c5f0e0-ad78-4b6e-91a4-450931966926)

  - **In a cloudshell stage the example WordCount pipeline on dataflow as a job**
    - **Run the command** 
      python3 -m \
      apache_beam.examples.wordcount \
      --region us-central1 --input \
      gs://dataflow-samples/shakespeare/kinglear.txt \
      --output \
      gs://dataflow-apache-quickstart_dataflowpoc0414/results/output \
      --runner DataflowRunner \
      --project dataflowpoc0424 \
      --temp_location \
      gs://dataflow-apache-quickstart_dataflowpoc0414/temp/
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e90a07eb-0615-4ce9-b281-b9592a694b57)

    - Go to the Dataflow console, to check the status
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1d092d1f-f035-413f-8f23-deede0098dcc)

    - After the job is complete, the status is shown in Cloudshell and Console
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6ea5685c-bd4d-4466-855e-47901d0a20e1)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/414bc496-0159-40cd-a349-622fe3efcc0c)

  - **View the output of the job**:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ce197e8b-9d18-460a-acba-350c1d6142a6)
    - The **"results" folder** contains the **count of all the unique words** in the input text. To read the results, click the file that starts with output, and then **click Download**.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/40968312-83ef-45e1-a5f1-a68e0fa5b9e8)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1dc25c4e-f63f-40c8-a0ff-6b11d33943f9)

    - The **"temp" folder** contains **binaries** that were created for the job execution.

  - **Cleanup**
    - Delete the bucket
    - Remove the Python dependencies and virtual environment: rm -rf env
    - Delete the project
