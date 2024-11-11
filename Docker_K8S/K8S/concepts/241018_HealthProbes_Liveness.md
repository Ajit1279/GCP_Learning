- Reference: https://www.youtube.com/watch?v=x2e6pIBLKzw&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=19

- **Basics:**
  - **Health Probes**: Monitoring the system to ensure systems are healthy i.e. automatically recover the application if failed
    - **Startup Probe**: If the applications start slowly and if this probe is configured then it'll wait for the time specified and then rest of the probes will be active 
    - **Readiness**: If the Readiness checks are configured, the applications serves the other systems / users only if the readiness checks are pass.
    - **Liveness**: Continuos monitoring & recovery of the live applications


      ![image](https://github.com/user-attachments/assets/94dae1a9-daa5-432d-b7f8-001c0f1b4374)

  
   
------------------------------------------------------- 
- **Command-Probe Demo**
  - These type of probes **run a command for the healthcheck and takes action based on it's response**
      
  - As usual set-up the [environment](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/KindClusters.md)

  - Create [liveness-c.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/liveness-c.yaml) and apply it **sudo kubectl apply -f liveness-c.yaml**
    - This yaml creates an empty file healthy and then waits for 30 secs. Then it removes the file and waits for 10 mins.

    - The **probes are specified in the spec.liveness section of yaml**
      - **As a probe**, it tries to open (cat) the file /tmp/healthy 
      - **initialDelaySeconds: time** specified until which **the probe will wait** for the **"initial healthcheck"**
      - **periodSeconds:** Frequency of the subsequent healthchecks. The prob will be executed as per the frequency specified.

      ![image](https://github.com/user-attachments/assets/97de0be3-ee7e-4cfc-b8f9-3d8f18621a80)

  - Type **sudo kubectl get pods --watch**. As seen the prob has failed, so the pod has restarted multiple times

      ![image](https://github.com/user-attachments/assets/428b52f6-a837-4b69-a79e-cee3a70a188c)

  - Type **sudo kubectl describe pod liveness-exec**

      ![image](https://github.com/user-attachments/assets/160d5942-719f-4af6-8e51-1cd8a907827f)

  - Finally it shows:

     ![image](https://github.com/user-attachments/assets/aaca68b6-095b-4e13-a3ca-1046c2e21ec5)


------------------------------------------
- **http-Probe command Demo**
  
  - Create [liveness-http.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/liveness-http.yaml)
  
    - In spec.LivenessProbe **httpsGet** is specified instead of exec against a **path /healthz** at **port 8080**

    - If it doesn't get response back the probe fails.

  - Run command: **sudo kubectl apply -f liveness-http.yaml**

      ![image](https://github.com/user-attachments/assets/b0805f8e-abfe-4273-b20f-f782b424ae3e)

  - Type: **sudo kubectl get pods --watch**. As you can notice kubelet has restarted pod 6 times by now

      ![image](https://github.com/user-attachments/assets/61e1feaa-8bd5-4bc9-9471-a2f089bc44e0)

  - Now let's create healthz file in the container: **sudo kubectl exec -it hello -- /bin/bash** is not working

     ![image](https://github.com/user-attachments/assets/b0e93a70-7f0f-4e69-aabb-9b1eef6b97b6)

  - Keep trying and finally healthz file is created.

     ![image](https://github.com/user-attachments/assets/bdd937c8-5bab-44f4-9109-c7b1f381fa12)

  - The pod is still not ready, it's in CrashLoopBackOff status, as the port is not open

     ![image](https://github.com/user-attachments/assets/d1b2bc7c-4226-4790-b3ee-c6e1ef76eafa)

------------------------------------------
- **tcp-probe command Demo**
  - Create [liveness-tcp.yaml](https://github.com/piyushsachdeva/CKA-2024/tree/main/Resources/Day18)

  - The probe checks if the port 8080 is open. We are using a proxy image in this yaml.

  - Let's apply this config: **sudo kubectl apply -f liveness-tcp.yaml**

      ![image](https://github.com/user-attachments/assets/541f3d71-28f4-4b4b-bef3-bb1d45b8d61f)

  - Then **sudo kubectl get pods --watch**. The pod gets ready and keep restarting intermittently 

      ![image](https://github.com/user-attachments/assets/a290743a-7748-4199-a768-44383cc67950)

  - Type **sudo kubectl describe pod tcp-pod**

      ![image](https://github.com/user-attachments/assets/b2a51e3b-5419-46b0-bb52-14b3d73a33e6)

  - Type command: **sudo kubectl get pods/tcp-pod -o yaml | less**. You can see that **failureThreshold is 3**, which means if there's **no successful response even after 3 probes, it'll restart the pod**. successThreshold is 1, which means the application will be **marked as live if the first probe is successful**

      ![image](https://github.com/user-attachments/assets/97d9a3f9-4aad-42f6-bb4c-c1d5111e96a0)

  -  Please note that Kubernetes has also added the tolerations to the pod

      ![image](https://github.com/user-attachments/assets/6116cdf6-311d-4662-a77c-a908fa172b9b)
