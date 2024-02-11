- Reference: https://cloud.google.com/functions/docs/calling/google-analytics-firebase

- Basics: 
  - User information such as application information or device information can be found in the userDim property.
  - Information about the logged event can be found in the eventDim array.
  - "Name" field in array holds the conversion event name (such as in_app_purchase).

- Create [main.py](https://github.com/Ajit1279/GCP_Learning/blob/main/20240204_CldFunctions/20240211_Python/0211_Firebs/0211_Analytics/main.py)

- Deploying function:
  - Specify the event type and project in which you have Firebase Auth configured
  - The following gcloud command deploys a function that triggers when a user makes an in-app purchase:
      gcloud functions deploy cf-hello_analytics-python \
      --entry-point  hello_analytics \
      --trigger-event providers/google.firebase.analytics/eventTypes/event.log \
      --trigger-resource projects/myprojec21/events/in_app_purchase \
      --runtime python312     
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6aac2411-edf4-42d3-aac9-5ef124629a42)

- It failed with an error:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/cd476250-89c5-4bba-afc4-9c23a59c3a44)

- **Set-up firebase project** Refer [Get Started with Google Analytics](https://firebase.google.com/docs/analytics/get-started?platform=web)
  - Search "Firebase" in Google Cloud Console.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1f5ff2c1-5218-4abd-9960-719cf4ee6ffd)

  - Select "Get Started for Free"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c0e47c25-f3d8-478a-86a1-5ebd504524e1)

  - It'll open Firebase console
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7077ffb4-1a62-484d-8001-f4c56ca787ac)

  - click on "Create a project". (Sparks plan is free, but we'll enable it later)
  - In the next screen, select your GCP project name which you want to use with Firebase, accept the terms and click "Continue"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/49318f34-5397-45a1-bbf2-08c8b077b1f1)

  - Confirm Firebase billing plan
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/11bd134c-71f1-41fc-94ec-3ec933726312)

  - It's using pay as you go Blaze Plan, but it's also free for Analytics and No-cost usage from spark plan is also included. Please refer screenshots below:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e4090b9f-9cd0-4a10-af3e-2275eb661a07)

  - Click on Continue in step2 of 4, the next screen displays. Ensure to "Enable Google Analytics for this project is selected
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/79a79f92-6dbe-453f-929b-cc64e78c0cff)

  - Keep "Analytics Location" as United States and click on "Add Firebase"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ba15d1c1-4164-430c-b7ec-6fe125f4385b)

  - It may take a while to create a project. Once ready, it'll display a message
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e963a8fc-5a12-4462-9de1-c9bce57abcfb)

  - To avoid billing, click on "modify" the plan
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d0a5cc83-da1a-4ced-8f24-dab9b942faea)

  - Select "Spark" plan
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6a30738d-a4b5-4b52-8573-290849e49697)

  - Select to downgrade a project
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/51079b81-217e-4c5a-b39d-2a491d42e2a4)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/15610122-42c2-4b5a-aa6f-fc8690505d8d)

-  Rerun the deployment command
  - Run the command:
    gcloud functions deploy cf-hello_analytics-python \
      --entry-point  hello_analytics \
      --trigger-event providers/google.firebase.analytics/eventTypes/event.log \
      --trigger-resource projects/myprojec21/events/in_app_purchase \
      --runtime python312

  - It gave an error
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ab570f0c-6800-4e88-b9f8-64790700bf17)

  - So changed the command as shown below (replaced GCP project name with Firebase project name). But, it gave the same error. 
      gcloud functions deploy cf-hello_analytics-python \
      --entry-point  hello_analytics \
      --trigger-event providers/google.firebase.analytics/eventTypes/event.log \
      --trigger-resource projects/myproject1/events/in_app_purchase \
      --runtime python312
  
  - As per suggestion in [stackoverflow post](https://stackoverflow.com/questions/54451457/firebase-cloud-functions-http-error-code-403), tried using "firebase login", but it didn't work
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2e3630ea-7f85-4ff7-9312-d84f4fb000c1)

  - Click on Build --> Functions and selected my function name
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/cc814805-34ec-4320-8404-35295a18ede1)

  - Referring to the [Firebase CLI reference](https://firebase.google.com/docs/cli#mac-linux-npm), enter command: npm install -g firebase-tools
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/739247f8-ed43-4fdf-bc76-19965bf249df)

  - Go to iAM ---> Service Account ---> manage permissions
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a9323283-6d52-4562-a48e-ba67b18f9de8)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/749c81fb-cb6c-48c2-8c5e-72c2473485c5)

  - Referring to one more [Stackoverflow post](https://stackoverflow.com/questions/57384609/gcloud-functions-deploy-permission-denied-when-deploying-function-with-specifi), [additional configurations](https://cloud.google.com/functions/docs/reference/iam/roles#additional-configuration) are required for deploying cloud functions. 

  - Selected firebase service account and grated "Service Account User" access to it. It still failed.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f2aafc7f-e2d9-47da-a108-f21afcbcfaac)

  - So finally referring to the error message, enabled billing for the "firebase project"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/74d2e250-951b-4e7d-bc6e-b153f75fe32b)
 
  - And, it started deploying the function :D and finally deployment was successful!!! :)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9997c163-3bca-4af4-a02d-720cb9b2ee74)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/121cbb25-43bd-4cbd-b121-ebc9d598f7e7)

   
- Now Let's check how to simulate "in-app-purchases" 
- ds
- dsd

 
