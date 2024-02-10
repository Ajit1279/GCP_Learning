- Reference: https://cloud.google.com/functions/docs/writing/write-event-driven-functions
- use event-driven functions when you want a function to be invoked automatically in response to an event that occurs in your cloud environment.
- [CloudEvents](https://cloudevents.io/): An industry-standard specification for describing event data 
- There are two ways to implement event-driven functions:
  - 1st gen:
    - For Node.js, Python, Go, and Java runtimes, use [Background Functions](https://cloud.google.com/functions/docs/writing/write-event-driven-functions#background-functions).
    - For .NET, Ruby, and PHP runtimes, use [CloudEvent functions](https://cloud.google.com/functions/docs/writing/write-event-driven-functions#cloudevent-functions).
  -  2nd gen: for all runtimes, use [CloudEvent functions](https://cloud.google.com/functions/docs/writing/write-event-driven-functions#cloudevent-functions).
  - In Node.js, you register a CloudEvent handler function with the Functions Framework for Node.js. Your handler function must accept a CloudEvent object as an argument.
 
- **Trigger your functions**
  - [Eventarc](https://cloud.google.com/functions/docs/calling/eventarc)
  - [Cloud Pub/Sub Events](https://cloud.google.com/functions/docs/calling/pubsub)
  - [Cloud Storage Triggers](https://cloud.google.com/functions/docs/calling/storage)
  - [Cloud Firestore triggers](https://cloud.google.com/functions/docs/calling/cloud-firestore)
  - [Firebase triggers](https://cloud.google.com/functions/docs/concepts/functions-and-firebase)
  - [Logging triggers](https://cloud.google.com/functions/docs/tutorials/cloud-audit-logs)     


- Enable event-driven function retries: 

