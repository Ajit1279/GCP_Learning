- **This involves below Google Cloud Products:**: Please search Security and indentity in [GCP Docs](https://cloud.google.com/docs)
- [**Private Google Access**](https://cloud.google.com/vpc/docs/private-google-access#pga) is **not a product**, but an **important concept** regarding security.

  - **1. Security:** 
    - [Access Context Manager:](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240227_AccessContextManager) **Allows administrators to define fine-grained, attribute based access control for projects and resources in Google Cloud. e.g. IP Address, device types, user identity etc.** 
    - Access Transparency
    - [Binary Authorization](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240224_BinaryAuthorization) : **Service that provides policy-based deployment validation and control for images deployed to GKE, Anthos Service Mesh (ASM), Anthos Clusters, and Cloud Run.**
    - Certificate Manager
    - Cloud Asset Inventory
    - Cloud Audit Logs
    - Sensitive Data Protection
    - Cloud External Key Manager
    - [Cloud HSM](https://cloud.google.com/kms/docs/hsm): allows you to host encryption keys and perform cryptographic operations in a cluster of FIPS 140-2 Level 3 certified HSMs.
    - [Cloud Key Management Service (KMS)](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240225_KMS): **Service that allows you to create, import, and manage cryptographic keys and perform cryptographic operations in a single centralized cloud service.**
    - Risk Manager
    - [Secret Manager](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240214_SecretManager) : **Provides tools for storing, managing, and accessing sensitive data in your applications.** 
    - Security Command Center
    - **[VPC Service Controls](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240302_VPCServiceControls)** - **Mitigates data exfiltration risks by isolating resources of multi-tenant Google Cloud services. Enforce adaptive access control based on IP range or device trust for accessing Google Cloud resources from outside privileged networks.**
   
  - **2. Identity and Access**
    - Assured Workloads
    - BeyondCorp enterprise
    - Certificate Authority Service
    - [Cloud Identity](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240310_CloudIdentity)
    - Identity and Access Management
    - **[Identity-Aware Proxy](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240302_IdentityAwareProxy)**: You can adopt an application-level access control model instead of using network-level firewalls. 
    - Identity Platform
    - Managed Service for Microsoft Active Directory
    - Resource Manager
    - Titan Security Keys
       
  - **3. Investigation and Response**
    - Chronical Security Operations
    - Chronicle SIEM
    - Chronical SOAR
       
  - **4. User Protection Services**
    - Phishing Protection
    - reCAPTCHA Enterprise
    - Web Risk 

=========================
Architectures
=================
- **[1. Security Log Analytics](https://github.com/Ajit1279/GCP_Learning/tree/main/20240214_Security_Identity/20240316_Security_LogAnalytics)**
