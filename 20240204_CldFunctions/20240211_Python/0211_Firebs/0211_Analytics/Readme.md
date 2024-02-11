- Reference: https://cloud.google.com/functions/docs/calling/google-analytics-firebase
- Reference Git Repo: https://github.com/GoogleCloudPlatform/python-docs-samples/tree/555b9d630d21c08c2e9cb94b1a53780f602290f0/functions/firebase

- Basics: 
  - User information such as application information or device information can be found in the userDim property.
  - Information about the logged event can be found in the eventDim array.
  - "Name" field in array holds the conversion event name (such as in_app_purchase).

- Create [main.py](https://github.com/Ajit1279/GCP_Learning/blob/main/20240204_CldFunctions/20240211_Python/0211_Firebs/0211_Analytics/main.py)
- Create [requirements.txt](https://github.com/Ajit1279/GCP_Learning/blob/main/20240204_CldFunctions/20240211_Python/0211_Firebs/0211_Analytics/requirements.txt)
- Create [firebase.json](https://github.com/Ajit1279/GCP_Learning/blob/main/20240204_CldFunctions/20240211_Python/0211_Firebs/0211_Analytics/firebase.json)

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

  - Referring to the error message, enabled billing for the "firebase project"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/74d2e250-951b-4e7d-bc6e-b153f75fe32b)
 
  - And, it started deploying the function :D and finally deployment was successful!!! :)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9997c163-3bca-4af4-a02d-720cb9b2ee74)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/121cbb25-43bd-4cbd-b121-ebc9d598f7e7)

   
--------------------------------------------
---------------------------------------------
- Now Let's check how to simulate "in-app-purchases" 
- ds
- dsd

 
