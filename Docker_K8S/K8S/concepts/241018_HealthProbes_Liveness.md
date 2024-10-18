- Reference: https://www.youtube.com/watch?v=x2e6pIBLKzw&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=19

- **Basics:**
  - **Health Probes**: Monitoring the system to ensure systems are healthy i.e. automatically recover the application if failed
    - **Startup Probe**: If the applications start slowly and if this probe is configured then it'll wait for the time specified and then rest of the probes will be active 
    - **Readiness**: If the Readiness checks are configured, the applications serves the other systems / users only if the readiness checks are pass.
    - **Liveness**: Continuos monitoring & recovery of the live applications


      ![image](https://github.com/user-attachments/assets/94dae1a9-daa5-432d-b7f8-001c0f1b4374)

  - The **probes are specified in the spec section of yaml**
    - **initialDelaySeconds: time** specified until which **the probe will wait** for the **"initial healthcheck"**
    - **periodSeconds:** Frequency of the subsequent healthchecks
   
------------------------------------------------------- 
