- Reference: https://www.youtube.com/watch?v=z6XjbuRl6LE&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=39
- https://kubernetes.io/docs/tasks/debug/debug-cluster/

- Basics:
  - Objective of this demo is fix the cluster in broken state
  - Kube-apiserver should be your first troubleshooting step
  - We can not use docker ps command as our ccluster is on 1.30 version, instead use crictl command and review the logs
  - Go to etc manifests directory and check api server yaml
  - If it's correct next step is to check kubeconfig file in $HOME/.kube
  - The pod is not running: describe the pod to check the events, check if kube-scheduler is healthy    
