- **CF_n_Logs.tf**
  - There was an error as Cloud Run APIs and Cloud Build APIs were not enabled
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9b15f26f-01e0-4c57-9a54-794d33974ebd)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f4fdcadb-543e-49e3-86e6-ccdec633bd8d)
  
  - https://stackoverflow.com/questions/77323404/error-code-13-while-deploying-google-cloud-function-terraform-from-dev-to-qa
  - Finally realized that it was a silly mistake. I created index.json instead of index.js :D
  - Once I made the required changes, the terraform script ran successfully
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/755f132d-2b8b-425e-a698-08d70b9d5af7)

  - Click on the uri: https://function-v2-nhjx3v2mbq-uc.a.run.app/
  - It displays "Hello World"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/481de983-98e9-4cb3-bbff-fee37613032c)

