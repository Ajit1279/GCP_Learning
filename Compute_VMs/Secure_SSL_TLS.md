- **Install Apache WebServer and Hello World App on it:**
  - SSH into your VM: gcloud compute ssh linux-web-server --zone=us-central1-c
  
  - Copy the external IP of the VM: 35.238.12.6
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/14cdb60d-43bb-4157-884e-8147332a528e)

  - Run the command to install Apache:   sudo apt-get update && sudo apt-get install apache2 -y

  - After installing Apache, the operating system automatically starts the Apache server. Verify that Apache is running: sudo systemctl status apache2
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b4450d27-72df-4695-b0c8-db53b44440ee)

  - Overwrite the Apache default web page:  echo '<!doctype html><html><body><h1>Hello World!</h1></body></html>' | sudo tee /var/www/html/index.html

  - Open a browser and navigate to the website: http://35.238.12.6/
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c63b9c30-ccd8-453f-938c-b4c75bb07090)
 
- **Set-up iAM permissions to register a domain**
  - Go to IAM & Admin > IAM, find your account and then click Edit Principal and _Cloud Domains Admin_ role and save.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d08ad6a8-cfae-4989-ad15-c6c894329d85)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/fa9b68fe-cd2a-4e9b-aabf-a0a81ce329e9)


  - Register a domain using Cloud Domains:
    - Go to network services > Cloud Domains , enable "Cloud Domains API" and click on **Register Domain**.  
    - Search for domain name and add to cart
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/aabd09ce-eeae-4e58-b5bf-da37499efec5)

    - Fill-up the details and click on **Register**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1827adc8-bc54-4233-883a-abbda886d266)

- **Connect your domain to VM instance**
  - Click on the domain name just created. On the Registration details page, click the DNS details tab. Alternatively you go to Network Services >> Cloud DNS
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/74990b3c-2fbe-4630-9953-f619a0e834f2)

  - Your NS and SOA records are created for you.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4d2f3598-d6c5-4f64-aeca-f3824d62036a)

  - Click on Add Standard
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/970374de-cd26-4550-a066-16465fd745f4)
 
  - Choose **A** in Resource Record Type, keep default values in DNS Name, TTL and  routing policy. In IPV4 enter the external IP Address of the VM created above.      Click Create
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/de7d5d33-a06a-4cea-baee-4839e450a99b)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/24172a5f-ebdb-4d23-994e-9510ef6a1de3)

  - Verify the set-up: dig +trace gcpajit80.com  This proves set-up is successful
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/8e3cc6db-d7ae-4025-994b-6c2e648fc5b1)
 
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/c52f3bd2-46df-42a3-ad69-70e415335224)

- **YYaayyy!!! Your website is now live**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/92d2720d-4100-491e-a5bf-8cb29671a042)

- **Now Let's configure TLS and SSL certificate**
  - To verify that an Apache web server has been set up for your site, run the following command: cat /etc/apache2/sites-available/000-default.conf
  It displays the details below:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d4029e62-943c-469c-bece-4d8cb4220c84)

  - To generate SSL certificate run the command: sudo apt-get install certbot python3-certbot-apache
  
  - Run the following command to generate and install the SSL certificate for the Apache website on your VM instance: sudo certbot --apache
  - When prompted enter the email address
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1e78a4e9-a1b8-4561-88e7-23b0618ddc32)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a28a2f8a-694d-4ef3-962f-6f970f816f26)

  - Enter the name of the site we created : gcpajit80.com
    **Congratulations! You have successfully enabled https://gcpajit80.com**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/30c3fb36-6ef9-437b-819c-5100817dc8f0)
 
  - Restart the Apache web server: sudo service apache2 restart
  
  - https has been enabled, but the site is not reachable (this could possibly due to the zone being us-central1-c)
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/75203508-ab30-469c-a99e-bf34ed48fc3e)
 
