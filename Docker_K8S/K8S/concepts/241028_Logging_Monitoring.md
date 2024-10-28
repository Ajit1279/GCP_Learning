- Reference: https://www.youtube.com/watch?v=cNPyajLASms&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=38
- Reference: https://github.com/kubernetes-sigs/metrics-server
- 

- Basics:
  - Kubelet does container management at node level, it set-up communication between worker node and control plane. It also collects pod data
  - cAdvisor only collects matrix from containers, aggregates and share with kubelet 
  - Mertics server will need to be installed on K8S which exposes these to API server. 

    ![image](https://github.com/user-attachments/assets/abfba7bc-40e9-40f3-a1a1-eca0734e42e2)

  - docker was the default container run time in earlier versions. Now we have crictl
