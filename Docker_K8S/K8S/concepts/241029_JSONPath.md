- Reference: https://www.youtube.com/watch?v=l9_UDSaiFj4&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=41
- Reference: https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/
- Reference: https://kubernetes.io/docs/reference/kubectl/jsonpath/

- Basics:
  - Suppose you type a command kubectl get nodes, it'll interact with the server (cluster) as an API request. It returns the response in JSON payload format which is then converted by kubectl in human readable format

     ![image](https://github.com/user-attachments/assets/199f28bd-a121-44c1-8c95-d3a038c33dfa)

  - Entire JSON file is in dictionary format. The root level dictionary is denoted by $ e.g. $.metadata.labels
  - However K8S doesn't use $. so our command will be something like k get pods-o={.metadata.labels.} 
