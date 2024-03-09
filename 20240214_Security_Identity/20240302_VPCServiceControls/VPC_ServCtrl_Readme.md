- References:
  - https://cloud.google.com/vpc-service-controls/docs
  - https://cloud.google.com/vpc-service-controls/docs/overview
   
- **Basics purpose is:**
  - **[Isolate Google Cloud resources and VPC networks](https://cloud.google.com/vpc-service-controls/docs/overview#isolate)**
    - **Service perimeter creates a security boundary specifically with Google Cloud managed services** (**doesn't block** access to third-party APIs or services on the internet.)
    - **Extend perimeters to on-premises networks using authorized VPN or Cloud Interconnect landing zone VPC networks.**
  - **Protect your highly sensitive data** (content stored in Cloud Storage, BigQuery etc.) **NOT designed to enforce controls on metadata**
  - **Protect against accidental or targeted action by external / insider entities**
  - **Ensure resources can only be accessed from trusted networks**, thus **Prevent access from unauthorized networks using stolen credentials**
  - **Minimize unwarranted data exfiltration risks (e.g. from Cloud Storage, BigQuery).** even if the data is exposed by misconfigured IAM policies.
  - **Monitor resource access patterns** across your service perimeters **using [Cloud Audit Logs](https://cloud.google.com/vpc-service-controls/docs/audit-logging)**.
  - Google Cloud also provides a restricted **virtual IP (VIP), which allows services access without exposing those requests to the internet**.
  - **Provides [Dry run mode](https://cloud.google.com/vpc-service-controls/docs/dry-run-mode) to monitor / identify unexpected or malicious attempts to probe accessible services.**
  - **Implements following controls**:
    - Clients within a perimeter do not have access to unauthorized resources outside the perimeter.
    - Cannot copy data to unauthorized resources outside the perimeter using _gsutil cp_ or _bq mk_.
    - Data exchange secured by ingress and egress rules
    - **Context-aware access** to resources based on identity type (service account or user), identity, device data, and network origin (IP address or VPC network).
      - Clients outside the perimeter need to use Private Google Access to access resources within a perimeter.
      - Internet access to resources within a perimeter is restricted to a range of IPv4 and IPv6 addresses.
    - [**Domain restricted sharing**](https://cloud.google.com/resource-manager/docs/organization-policy/restricting-domains)
    - **Uniform bucket-level access**
    - **[Multi-factor authentication](https://cloud.google.com/identity/solutions/enforce-mfa)**
    - **[Glossary](https://cloud.google.com/vpc-service-controls/docs/overview#glossary)**  
  
- **Steps**
  - [Service perimeter configuration](https://cloud.google.com/vpc-service-controls/docs/service-perimeters#stages)
    - You can include your project only in one service perimeter.  
    - **Create an access policy**
      - Collects service perimeters, access levels for your **organization**
      - You can have **multiple scoped access policies** for the **folders and projects**.
      - gcloud access-context-manager policies create --organization my-org --title my-access-policy
      - It gives an error since Org is not created
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9c949cb0-1c5f-4f4f-91a9-f8074f610c95)


    - **Secure Google-managed resources by [creating service perimeters](https://cloud.google.com/vpc-service-controls/docs/create-service-perimeters)**
      - After Service Peremeter is created, one can specify what services are accessible
      - Optinally allow access to protected services from outside the perimeter
      - After creation or changes, it takes **upto 30 mins** to take effect, with **error message: Error 403: Request is prohibited by organization's policy.**
      - Refer these [commands](https://github.com/Ajit1279/GCP_Learning/blob/main/20240214_Security_Identity/20240302_VPCServiceControls/Create_Serv_perimeter.sh) for details.
        - [Ingress, egress rules](https://cloud.google.com/vpc-service-controls/docs/ingress-egress-rules#benefits-ingress-egress) 
        - [Supported method restrictions](https://cloud.google.com/vpc-service-controls/docs/supported-method-restrictions)    

    - **Set up [VPC accessible services](https://cloud.google.com/vpc-service-controls/docs/vpc-accessible-services)**:
      - Access from network endpoints inside your perimeter is limited to a set of services that you specify.
      - Limits the set of services that are accessible from network endpoints inside your service perimeter.
      - **Applies only** to traffic from your **VPC network endpoints to Google APIs.**
      - **Does not apply** to the communication from **one Google API to another**
      - To ensure limiting access to the expected services:
        - **Specify individual services or include "RESTRICTED-SERVICES value" for perimeter to protect few services automatically** 
        - **Configure perimeter to protect services to be accessible.**  
        - **Configure VPCs in the perimeter to use the restricted VIP.**
        - **Use layer3 firewalls**


    - **Set up [private connectivity from a VPC network](https://cloud.google.com/vpc-service-controls/docs/private-connectivity)**
      - Offers private connectivity to hosts in VPC or an on-premises network
      - Uses private IP addresses to access Google APIs and services.
      - Requests to Google APIs must be sent through a [Cloud VPN](https://cloud.google.com/network-connectivity/docs/vpn) tunnel or a [Cloud Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect).
      - Hosts in a VPC network must have a **private IP address only**
      - Recommended to use **restricted.googleapis.com to access services that aren't supported by VPC Service Controls**
      - Two IP address ranges associated with the restricted.googleapis.com domain
        - **IPv4 range:** 199.36.153.4/30
        - **IPv6 range:** 2600:2d00:0002:1000::/64
      - For **on-premises networks:**
        - Simply configure **static route in the on-premises router**
        - **Announcing the restricted Google API address range** through **Border Gateway Protocol (BGP)**


    - **Allow [context-aware access](https://cloud.google.com/vpc-service-controls/docs/context-aware-access) from outside a service perimeter using ingress rules**

    - **Configure [secure data exchange](https://cloud.google.com/vpc-service-controls/docs/secure-data-exchange) using ingress and egress rules**: To allow communication across the perimeter boundary 
- ds
- ds
- d
- sd
- sd
- sd
- sd
- s
- ds
- d
- sd
- sd
- sd
- sd
- sd
- s
- d
