- References: https://cloud.google.com/iap/docs 

- **[Overview](https://cloud.google.com/iap/docs/concepts-overview)**
  - Establish **an application-level access control instead of network-level firewalls**.
  - A central **authorization** layer for applications accessed by **HTTPS**
  - The **fine-grained access controls implemented** by the product in use **without requiring a VPN**. 
  - A **resource** can only be **accessed through the proxy** by **principals who have the correct IAM role.** e.g. employees or contractors, or only a specific department.
  - **Scale across organization**: Define access policies centrally and apply them to all applications and resources.
  - IAP works with [signed headers](https://cloud.google.com/iap/docs/signed-headers-howto) or the App Engine standard environment [Users API](https://cloud.google.com/appengine/docs/standard/services/users?tab=python) to secure your app. 
  - **If IAP is enabled** for the app or backend service:
    - **information** about the protected resource (project number, request URL, any IAP credentials in request headers or cookies) is **sent to the IAP authentication server**.
    - IAP **checks user's browser credentials**.
      - **If valid**, those are **used to get the user's identity (email address and user ID) to check the user's IAM role and check if the user is authorized to access the resource**. 
    - **If none exist user is redirected to an OAuth 2.0 Google Account sign-in flow**. It is created automatially when IAP is turned-on for resources.
    - Post this **Authorization** checks if **IAP-secured Web App User role** is enabled.   


- **Limitations:** 
  - **If using Compute Engine or Google Kubernetes Engine**, **users** who can access the **application-serving port** of the Virtual Machine (VM) **can bypass IAP authentication**. To ensure security, you must take the following precautions:
      - **Firewall and load balancer** to protect against traffic that **doesn't come through the serving infrastructure.**
      - For **Cloud Run**, you can restrict access by using **ingress controls.**
      - Use **signed headers** or the App Engine standard environment **Users API**.
 
      
- **[Enable IAP for Compute Engine](https://cloud.google.com/iap/docs/tutorial-gce)**
  - Enable Compute Engine API
  - **Create compute engine template**. Enter the [start-up](https://github.com/Ajit1279/GCP_Learning/blob/main/20240214_Security_Identity/20240302_IdentityAwareProxy/startup.sh) commands in Management > Automation > Startup field.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8ffa437b-9dab-429e-837b-c96b82049a52)
  
  - **Create a Managed Instance Group**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/44bd169c-ee7e-45eb-8cbe-dfd6655c959c)

  -  
- ds
- d
- sd
- sd
- sd
- sd
- sd
- d
- sd
- sd
- sd
- sd
- s
- ds
- ds
- ds
- d
- sd
- sd
- sd
- s
- ds
- ds
- dsd 
