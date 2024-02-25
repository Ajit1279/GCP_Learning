- References: https://cloud.google.com/binary-authorization/docs
  
- [Configure a Binary Authorization policy with GKE](https://cloud.google.com/binary-authorization/docs/configure-policy-gke)
  - **Basics:**
    - It is a service that provides policy-based deployment validation and control for images deployed to Google Kubernetes Engine (GKE), Anthos Service Mesh, Anthos Clusters, and Cloud Run.
    - In this PoC, we'll view and configure the default rule in the policy. **Default rule allows all images to be deployed**
    - You then **set the default rule to disallow all images from being deployed** and attempt to deploy an image.
    - Please note **this is not how it works in real-world policies.**. In **real-world a policy**, Binary Authorization verifies the [attestation](https://cloud.google.com/binary-authorization/docs/key-concepts#attestations) before Binary Authorization enforcer allows the image to be deployed.

  - **Step-by-step instructions**
    - Enable the Artifact Registry, Binary Authorization APIs. (**Pricing**: INR 1.34 for clusters with Binary Authorization enabled) 
    - **Create a cluster with Binary Authorization enforcement enabled**
        gcloud container clusters create \
        --binauthz-evaluation-mode=PROJECT_SINGLETON_POLICY_ENFORCE \
        --zone us-central1-a \
        test-cluster

    - It may take several minutes
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f8e2623e-176e-457f-934b-72de565f5997)

    - It's created!!
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/de2c83ef-e505-4be8-a558-8e437eec54e5)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a746fb04-d28f-4548-9d7e-f12b43d54d63)

   - **View the default policy**: Export the policy YAML file as follows: gcloud container binauthz policy export 
    (**globalPolicyEvaluationMode: ENABLE means that Google-managed system images are exempted.**)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/60933ad6-6823-47c2-b225-40c60a22a025)

   - **Test the enforcement policy** by trying to deploy a sample container image to the cluster. 
    - **Update the local kubeconfig file:** which **provides the credentials and endpoint information** required **to access the cluster** in GKE.
       gcloud container clusters get-credentials \
       --zone us-central1-a \
       test-cluster
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6997d884-df50-4241-b079-1acc96b538c2)

    - Deploy the sample container image located at the path gcr.io/google-samples/hello-app in Container Registry: kubectl run hello-server --image gcr.io/google-samples/hello-app:1.0 --port 8080
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b9d009de-a237-43da-936f-6d3a6dc04eb7)

    - Run the command: **kubectl get pods** to verify that **the deployment was allowed by Binary Authorization** - 
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/137148e3-a486-4fa5-8add-67e4cab67f84)

    - Before proceeding to next step, delete the deployment: **kubectl delete deployment hello-server**. It gave an error
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5f84afbc-a02a-4cff-a57e-ba2b2df23019)

    - It gave an error:
  
    - sd 
- ds
- dsd
- sd
- sd
- sd
- sd
- sd
- sd
- sd
- sd
- s
- ds
- ds
- ds
- d


