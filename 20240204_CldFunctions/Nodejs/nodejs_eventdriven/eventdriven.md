- Reference: https://cloud.google.com/functions/docs/writing/write-event-driven-functions

- use event-driven functions when you want a function to be invoked automatically in response to an event that occurs in your cloud environment.
- An event is a discrete unit of communication, independent of other events. e.g. change to data in a database, a file added to a storage system, or a scheduled job.

- [CloudEvents](https://cloudevents.io/): An industry-standard specification for describing event data
  - [Google Cloud Events Git Repository](https://github.com/googleapis/google-cloudevents)
   
- There are two ways to implement event-driven functions:
  - 1st gen:
    - For Node.js, Python, Go, and Java runtimes, use [Background Functions](https://cloud.google.com/functions/docs/writing/write-event-driven-functions#background-functions).
    - For .NET, Ruby, and PHP runtimes, use [CloudEvent functions](https://cloud.google.com/functions/docs/writing/write-event-driven-functions#cloudevent-functions).
  -  2nd gen: for all runtimes, use [CloudEvent functions](https://cloud.google.com/functions/docs/writing/write-event-driven-functions#cloudevent-functions).
  - In Node.js, you register a CloudEvent handler function with the Functions Framework for Node.js. Your handler function must accept a CloudEvent object as an argument.

 
- **Trigger your functions**
  - [Eventarc](https://cloud.google.com/functions/docs/calling/eventarc)
    - All event-driven functions in Cloud Functions (2nd gen) use Eventarc triggers.
    - Lets you build event-driven architectures without having to implement, customize, or maintain the underlying infrastructure.
    - Offers a standardized solution to manage the flow of state changes, called events, between decoupled microservices.
    - When triggered, Eventarc routes these events to various destinations
    - Your Eventarc trigger's service account must have permission to invoke your function. By default, the Default compute service account is used.
    - Examples of specifying event filters for different types of google or third party events [here](https://cloud.google.com/eventarc/docs/targets#triggers).
      
  - [Cloud Pub/Sub Events](https://cloud.google.com/functions/docs/calling/pubsub) : https://github.com/Ajit1279/GCP_Learning/tree/main/20240204_CldFunctions/Nodejs/nodejs_eventdriven/20240210_pubsub

  - [Cloud Storage Triggers](https://cloud.google.com/functions/docs/calling/storage)

  - [Cloud Firestore triggers](https://cloud.google.com/functions/docs/calling/cloud-firestore)

  - [Firebase triggers](https://cloud.google.com/functions/docs/concepts/functions-and-firebase)

  - [Logging triggers](https://cloud.google.com/functions/docs/tutorials/cloud-audit-logs)     


- Enable event-driven function retries: 

