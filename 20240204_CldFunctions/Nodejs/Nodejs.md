 - Reference: https://cloud.google.com/functions/docs/writing
 - The **basic directory structure for Node.js functions** is as follows:
   - **index.js:** : https://github.com/Ajit1279/GCP_Learning/blob/main/20240204_CldFunctions/Nodejs/index.js
     - By default, Cloud Functions attempts to load source code from a file named index.js at the root of your function directory.
     - To specify a different main source file, use the main field in your package.json file.
   - **package.json**: https://github.com/Ajit1279/GCP_Learning/blob/main/20240204_CldFunctions/Nodejs/package.json

   - Your source code must define an entry point for your function, which is the particular code that is executed when the Cloud Function is invoked.
    - **HTTP Functions:** 
     -  Reference: https://cloud.google.com/functions/docs/tutorials/http
     -  Before you begin, enable the Cloud Functions, Cloud Build, and Artifact Registry APIs.
     -  Set-up Node.js development environment: https://cloud.google.com/nodejs/docs/setup
      - Follow instructions at: https://github.com/nvm-sh/nvm#installing-and-updating
       - To install NVM (Node Version Manager)run command: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash  
       - To verify installation run: command -v nvm
       - To install the latest version of Node.js, run command: nvm install stable
       - To check what version of Node.js that you're running, run the following: node -v
       - Node Package Manager (npm) for Node.js. Install it using command: npm install --save express
       - Install Cloud Client Libraries: npm install --save @google-cloud/storage
       - Set-up Authentication: gcloud auth application-default login
     - Preparing application
      - Download the zip file from git clone https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git
      - Download the index.js and package.json files in **hellowworldHttp** 
      - Add those files to the appropriate directory on GCP VM
     - Deploy the function:
       gcloud functions deploy nodejs-http-function \
        --gen2 \
        --runtime=nodejs20 \
        --region=us-central1 \
        --source=. \
        --entry-point=helloGET \
        --trigger-http
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a2c9f8a6-a3f6-4622-85c3-c5ab4e53de80)
  
     - It failed with the below error:
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6251cbc2-566d-4d1b-b082-c915d130ac0b)
    
     - https://console.cloud.google.com/logs/viewer?project=myprojec21&resource=cloud_run_revision/service_name/nodejs-http-function/revision_name/nodejs-http-function-00001-wih&advancedFilter=resource.type%3D%22cloud_run_revision%22%0Aresource.labels.service_name%3D%22nodejs-http-function%22%0Aresource.labels.revision_name%3D%22nodejs-http-function-00001-wih%22
     - Referring to the documentation on https://cloud.google.com/run/docs/troubleshooting#service-agent , checked if "serverless-robot-prod.iam.gserviceaccount.com" exist. It existed
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d202e8e9-cdfa-480e-aa79-65db9850ae1a)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d421ea87-2306-4858-aa3d-99b97d665e31)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/034ba715-0b6f-473a-89b6-0d8525e8545c)

     - sd
     - sd
     - sd
     - sd
     - sd
     - s
     - ds
     - ds      
    - **Event Driven Functions:**  
