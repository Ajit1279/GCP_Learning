- Reference: https://cloud.google.com/functions/docs/calling/pubsub
- Basics:
  - Pub/Sub trigger enables a function to be called in response to Pub/Sub messages.
  - Also specify a Pub/Sub topic.
  - Function will be called whenever a message is published to the specified topic.
 
- **Step-by-step instructions:**
  - Create pub/sub topic:
    - This is a mandatory step. In Cloud Functions (2nd gen), Pub/Sub topics are not automatically created when you deploy a function. 
    - gcloud pubsub topics create mypbsbtpc
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4f317001-6753-41a2-8c2d-96e16d77e05c)

  - Create [index.js](https://github.com/Ajit1279/GCP_Learning/blob/main/20240204_CldFunctions/Nodejs/nodejs_eventdriven/20240210_pubsub/index.js) file.
  - Deploy the function using command:
    gcloud functions deploy nodejs-pubsub-function \
    --gen2 \
    --runtime=nodejs20 \
    --region=us-central1 \
    --source=. \
    --entry-point=helloPubSub \
    --trigger-topic=mypbsbtpc
    
  - package.json file was missing, so it gave an error as shown below:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/383f9460-f3b0-4fa8-aafd-b0bf7509094a)

  - Created [package.json](https://github.com/Ajit1279/GCP_Learning/blob/main/20240204_CldFunctions/Nodejs/nodejs_eventdriven/20240210_pubsub/package.json) and reran the command to deploy
  - Provide confirmation to enable eventarc API
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c674875e-ba0c-4261-9339-5b69df716ec5)

  - Deployment restarted
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4af8eee3-9b38-47cc-a9e8-75c20c8dacaa)

  - Deployment is complete
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e2ae99fb-15d7-4b4f-a52e-b5561ba7b655)

  - Tried accessing the [url](https://us-central1-myprojec21.cloudfunctions.net/nodejs-pubsub-function) shown above, but it gave an error
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0bc683b8-9888-4553-8621-4132fef9d2cb)

  - Triggering a function:
    - Publish a message to a topic: gcloud pubsub topics publish mypbsbtpc --message="Ajit"
    - Read the function logs to see the results
      gcloud functions logs read \
      --gen2 \
      --region=us-central1 \
      --limit=5 \
      --nodejs-pubsub-function

 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/da5d7d5b-20a0-4086-b21b-9b871dd823f1)

 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/eb021373-8296-40dd-a3f2-eb935c549081)

 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9cf6b1d1-82b5-465c-badb-83f7a3e46e39)

 
  - Also published message manually
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e9197fa9-fa4a-4323-806d-1dee7918ea73)

  - Function details in Console:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/53547e67-9303-49a0-b698-bc6fc0f1adc8)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a5be16f9-4055-45ba-b1a0-1a5df80df2ab)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e9eab810-f8d0-429c-b25a-9b4d2a64dc4e)

 - Publish message using gcloud: gcloud pubsub topics publish mypbsbtpc --message="pub sub message using cloud CLI"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e6f9fae4-3382-4ef7-8989-09f290b29fe6)

 - Let's delete cloud function to avoid charges: gcloud functions delete nodejs-pubsub-function --gen2 --region us-central1
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8657f457-7f27-4577-b34e-826622ee44ff)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c40204e5-acae-441d-8625-a3cb68e24830)
  
