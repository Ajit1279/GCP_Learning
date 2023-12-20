1. **Create a private repository for all GCP "ENV Config" with separate folders for each GCP projects (e.g Market). Within this, there would be folders for each of the env (like SIT, UAT, Prod etc.)**

**a.** This folder in turn contains folders for various environments like SIT Env, UAT Env, Prod env. These folder contains configs for DB Proxy and application config

**b.** The folder also contain scripts for respective env deployments, Java installation, application installation, monitoring (e.g. AppD) installation, healthchecks,

**c.** The scripts for Prod and SIT deployments are almost same except few comments
        		    

2. **There's one more git repo for storing the terraform scripts**
   Please note, the **var.tf** files in this repo is used for the **declaration of variables, name, type etc.**
**a. Test Image Folder** There's a folder within this repository which contains all the details required for the dev image family, dev variables (project name, region, zone etc.).
 
This folder contain folder for terraform scripts for:
	**i. DBProxy:** contains terraform files for variables (hardcodes values for service project name, region name, image names, tags etc.) backend (storage), data (project id), locals (subnetworks), output (VM name, IP, FQDN etc.). All these details are used by main.tf during execution
	**ii. Application:** similar details as above for the application, which are used by main.tf for application image creation

**b. Prod image folder** - There's a similar folder for prod environment which contains the details for Prod

**c. groovy scripts** - Contains
	**i** Folder for each of the environments like SIT, UAT etc.
   	**ii** Folders for release process, service account renewal etc.
   	**iii** scripts for DB Proxy creation, env & app image creation.   
 

 
**3. All the required software packages (e.g. terraform etc.) are stored in the internal Nexus Repository. The development teams are not allowed to download anything from the internet directly.**

**4.** There's one more git repo (Source of Truth) one each for dev and prod.
i. It contains various tfvar files with the variables required for the tarraform execution. *tfvar files are used for giving the actual variable values during execution of terraform scripts* 
ii. These include files like project APIs, project metadata, project roles, project variables, service accounts names, service account roles, Shared VPC, firewall rules etc.
	**a Project APIs** - APIs enabled in GCP project
 	**b Project vars** - project name, project labels, region, zone, billing account etc.
  	**c Service Accounts** -  The service account description for app and terraform service accounts. 
   	**d Service Account Roles** - This contains user-group to role binding i.e. various service account roles and members (e.g. AD groups or service accounts) who can use those roles.
    	**e Shared VPC Users** - The list of service accounts which are authorised to use various shared VPCs within the project
     	**f gitignore file** - to interntionally untrack the files suh as tfstate, terraform directory, secrets.tfvars files, files that might appear in the root of the volume etc.
      
**5. Following are the prerequisites to kick-off the project creation**
	i. Access to the GCP Console
 	ii. Cloud SDK installed on the workstation and required set-up completed
  	iii. Create a GCP privilege account
   	iv. Jenkins access to your account and GCP instances
       	v. Creating a folder in Jenkins for your unique project identifier.
	vi. Jenkins Configs - e.g. Git Service Account, add this service account to github AD group, Nexus service account, adding this service account to Nexus AD group, access for the service account to nexus repository, adding user ids to the respective Jenkins project admin, build-engineer, developers etc. Create a pipeline for jenkins job, DB proxy VM creation job, job to configure sql proxy in dbproxy to connect to SQL instance, application VM  creation job, job to configure application and related services in the VM.
 	vii. Once these pre-requisites are ready run jobs in following sequence to:
  		a. Create VM for app infra
    		b. Configure software and related services on above VM
      		c. Create a image from the above VM
		d. Create test vm image from the above image for Tanium security scanning. An Ops ticket is required after this for image promotion to prod. Please note this is a manual process by central team.
  		e. After above step completed, run job to create VMs in Prod environment to connect SQL instance

**6. Release management CI/CD Jobs**
	i. The app uses inbuilt release management. Run these jobs from Jenkins. This will make the environment ready-to-use in prod

**7. Set-up alerting & monitoring** 
 
**8. Renew Service Account JSON Keys** - This is a security and compliance requirement. These are renewed every 30 days  

**9. Environment Refresh** - VMs and DB refershed every 15 days, image creation every 30 days. 
