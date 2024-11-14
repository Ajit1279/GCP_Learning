- References:
  - https://www.youtube.com/watch?v=njT5ECuwCTo&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=21
  - https://www.youtube.com/watch?v=njT5ECuwCTo&list=PLl4APkPHzsUUOkOv3i62UidrLmSB8DcGC&index=22


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


      - **HTTPS connection over internet:**
        - The server will have two keys as above public key and private key using utility called open SSL
        - Public keys are used for encryption. When there's a GET request from user, the public key is sent to the users
        - Users also have their own symmetric keys. **Users encrypt this symmetric key using public key**
        - This **"combined encrypted key"** will be sent to server and server will **decrypt it using it's private key**
     
              ![image](https://github.com/user-attachments/assets/f5a44fcb-0576-432a-9288-ece5090c64b1)

        - Now let's say, **if hacker gets hold of this combined encrypted key**, they can only read the encrypted data.
     
              ![image](https://github.com/user-attachments/assets/07b4dff2-dd91-4091-a466-7e990134ec15)
 
        - There's still a possibility of security breach in the above case.
        - Hackers can create a **dummy website** or **phishing email to get "user symmetric key"** and then create GET request on your behalf.
        - The server would respond to this GET request considering it as "authorised" request and share the "server - public key" with the user 
        -  start at 17:16
        -     

    
  -         
