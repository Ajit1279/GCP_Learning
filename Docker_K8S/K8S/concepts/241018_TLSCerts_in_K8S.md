- References:
  - https://www.youtube.com/watch?v=njT5ECuwCTo&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=21
  - https://www.youtube.com/watch?v=LvPA-z8Xg4s&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=22
  - https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#normal-user


- **SSL TLS Basics:**
  - If your data / credentials are not encrypted as shown below, it's highly likely that there's a security breach.

    ![image](https://github.com/user-attachments/assets/36b7d1ec-b997-4906-82e3-ac1ac383d67f)

  - So encryption keys are used to encrypt the data.
    - **Symmetric Encryption:**
      - Same key is used to encrypt and dycript the data. So the users will also need to share the keys with the server to decrypt the data.
      - If the hacker manages to access your key, then your security is compromised

    - **Assymtric encryption** is used to overcome this challenge and create a secure connection
      - **SSH connection**
        - Users have to create Public Key and Private Key to secure connection using ssh keygen
        - The data is encrypted using private keys
        - Public keys are shared with the other parties which is usually added to .ssh/authorized_keys file
        - While communicating private keys are shared with the server with ssh request to establish secure connection
        - Once the connection is established, server decrypts the data using public key and responds back to the user
 
          ![image](https://github.com/user-attachments/assets/764c14a2-384e-4668-9cbe-a755222c8e14)


      - **Connection over internet:**
        - The server will have two keys as above public key and private key using utility called open SSL
        - Public keys are used for encryption. When there's a GET request from user, the public key is sent to the users
        - Users also have their own symmetric keys. **Users encrypt this symmetric key using public key**
        - This **"combined encrypted key"** will be sent to server and server will **decrypt it using it's private key**
     
           ![image](https://github.com/user-attachments/assets/f5a44fcb-0576-432a-9288-ece5090c64b1)

        - Now let's say, **if hacker gets hold of this combined encrypted key**, they can read the encrypted data.
     
           ![image](https://github.com/user-attachments/assets/07b4dff2-dd91-4091-a466-7e990134ec15)
 
        - There's still a possibility of security breach in the above case.

        - **Hackers can create a dummy website or phishing email to get "user symmetric key" and then create GET request on your behalf.**

        - The server would respond to this GET request considering it as "authorised" request and **share the "server - public key" with the user**
     
           ![image](https://github.com/user-attachments/assets/159e8e19-1de1-45f3-8646-6d4975803c63)

        - The hacker would then send this "server - public key" back to the user. Hacker encrypts the data with it's own symmetric key and sends to user.
     
           ![image](https://github.com/user-attachments/assets/02ae6de4-ba35-4429-8ea9-012d8b7efa29)
  
      - **HTTPS Connection**
        - To avoid this, user and the server should be able to identify the legitimate / authorised traffic using certificates  

        - The server creates **Certificate Signing Request (CSR).** CSR is signed by **Certificate issuing authority (e.g. CA, Symentec, Digicert)**. **For private websites within the company, custom-CA is used not the public CA**

        - **CA validates the request** e.g. whether the requestor own the domain, authorise the requestor and then issues public and private certificate. **Private certificate is retained by server and public certifcates are issued to users to add in the browser**
     
          ![image](https://github.com/user-attachments/assets/7b7dfb46-d338-4c10-9fdc-3e8f71e5fc3c)
     

        - So instead of public key, the server **would send certificate in response to the GET request**
     
          ![image](https://github.com/user-attachments/assets/d9ea29c5-8ec9-47c5-b9c4-3babe2b7ebb9)

        - User's browser would validate if this certificate is issued to the same domain. If valid, the certificate is used to encrypt the traffic and send to the server

          ![image](https://github.com/user-attachments/assets/8932c37a-2ea5-422c-909e-dba73f436786)

        - The Certificate Authority generates Root Certificate and client and server need to generate their own public and private certificate using those
     
          ![image](https://github.com/user-attachments/assets/9f27dba3-393d-45ab-9e41-551e92e5478c)

        - Files having **.cert or .pem extensions are public** certificates. Files having **.key or -key.pem are private** certificates
           
          ![image](https://github.com/user-attachments/assets/c3315299-d38b-4528-8420-8ae9f59eabfa)

    
------------------------------------------- 
- Demo
  - As shown in the logical diagram below, connections between users and K8S need to be secure. Likewise connections amongst various K8S components will also need to be secure (lock signs)

    ![image](https://github.com/user-attachments/assets/2d243849-d3c9-4366-a6d5-10e11c821e2e)

    ![image](https://github.com/user-attachments/assets/750edc2f-a469-4960-8859-42deb7788e44)

  - Create a compute engine instance and the **new user requesting access have to type commands below until approval request is generated** 

        openssl genrsa -out newadmin.key 2048

     ![image](https://github.com/user-attachments/assets/bd7f06c6-cb3e-4ef4-8fec-2c5653751b84)
 
  - Create a new Certificate Signing Request using this key

        openssl req -new -key newadmin.key -out newadmin.csr -subj "/CN=newadmin"

     ![image](https://github.com/user-attachments/assets/db0ca339-addc-4ab4-9cb7-adb9823c6741)

  - Kubernetes has provided an API to create K8S certificates using this CSR file. We have to create [certsign.yaml](https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/K8S/concepts/certsign.yaml) by referring the [documentation](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#create-certificatessigningrequest).

  - The spec.request in the yaml needs to be populated using the base64 encoded CSR. Also the key has to be in single line in the yaml

        cat newadmin.csr | base64 | tr -d "\n"

  - Apply the certsign.yaml:

        sudo kubectl apply -f certsign.yaml


      ![image](https://github.com/user-attachments/assets/0058c379-cf2a-4ea7-bcfb-845984f73c9b)
 

  - Type the below command to display CSRs. 

          sudo kubectl get csr


      ![image](https://github.com/user-attachments/assets/9943666f-babb-4023-a904-bbe17da8ea4a)

  - The status of the CSR is pending because it's not approved yet. Type below command:

          sudo kubectl describe csr newadmin


      ![image](https://github.com/user-attachments/assets/58c04ee6-0cd0-4aac-b7b5-700e9435ecbe)


  - In real world scenarios, admins with specific access will have to approve it. So type commands below and it shows that cert is approved:

          sudo kubectl certificate approve newadmin
          sudo kubectl get csr

     
      ![image](https://github.com/user-attachments/assets/3b3028d8-ee35-44c7-b16a-a5497a2efe44)

          
  - The cert has to be shared with the user by following below steps 

          sudo kubectl get csr newadmin -o yaml > issuecert.yaml

      ![image](https://github.com/user-attachments/assets/467f83fa-aab0-402f-8a4e-1baaa7cc90d3)


  - The certificate generated above is highlighted in yellow. It's in base64 encoding, so it needs to be decoded first. Copy the certificate string and type

          echo <cert string in double quotes> | base64 -d

      ![image](https://github.com/user-attachments/assets/70abb2a5-1629-4f80-963d-c9d23ca752d4)

  - This certificate needs to be imported in kubeconfig file and assign certain permissions to it so user can access K8S servers using this certificate  
