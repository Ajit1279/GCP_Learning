- References: https://cloud.google.com/binary-authorization/docs
  
- [Configure a Binary Authorization policy with GKE](https://cloud.google.com/binary-authorization/docs/configure-policy-gke)
  - **Basics:**
    - It is a service that provides policy-based deployment validation and control for images deployed to Google Kubernetes Engine (GKE), Anthos Service Mesh, Anthos Clusters, and Cloud Run.
    - In this PoC, we'll view and configure the default rule in the policy. **Default rule allows all images to be deployed**
    - You then **set the default rule to disallow all images from being deployed** and attempt to deploy an image.
    - Please note **this is not how it works in real-world policies.**
    - In **real-world a policy**, Binary Authorization verifies the [attestation](https://cloud.google.com/binary-authorization/docs/key-concepts#attestations) before Binary Authorization enforcer allows the image to be deployed.

  - **Step-by-step instructions**
    - Enable the Artifact Registry, Binary Authorization APIs. (**Pricing**: INR 1.34 for clusters with Binary Authorization enabled) 
    - **Create a cluster with Binary Authorization enforcement enabled**
        gcloud container clusters create \
        --binauthz-evaluation-mode=PROJECT_SINGLETON_POLICY_ENFORCE \
        --zone us-central1-a \
        test-cluster

    - sd
    - sd
    - s
    - ds
    - ds
    - d
    - sd
    - sd
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


