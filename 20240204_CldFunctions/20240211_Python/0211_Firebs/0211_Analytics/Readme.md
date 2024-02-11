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

- Refer [Get Started with Google Analytics](https://firebase.google.com/docs/analytics/get-started?platform=web)
  - 

  - sd
  - sd
  - sd
  - sd
  - sd
  - sd
  - 
- ds
- ds
- dsd

 
