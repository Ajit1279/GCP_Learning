1. **Create a private repository for all GCP "ENV Config" with separate folders for each GCP projects (e.g Market). Within this, there would be folders for each of the env (like SIT, UAT, Prod etc.)**
	a. This folder in turn contains folders for various environments like SIT Env, UAT Env, Prod env. These folder contains configs for DB Proxy and application config 
	b. The folder also contain scripts for respective env deployments, Java installation, application installation, monitoring (e.g. AppD) installation, healthchecks, 
	c. The scripts for Prod and SIT deployments are almost same except few comments
		    
2. **There's one more git repo for storing the terraform scripts**
	a. The gmi folder within this repository contains all the details required for the image family, variables (project name, region, zone etc.). The gmitest folder contains similar details for Dev environment
	b.  Both these folder contain folder for terraform scripts for:
		i. DBProxy: contains terraform files for variables (hardcodes values for service project name, region name, image names, tags etc.) backend (storage), data (project id), locals (subnetworks), output (VM name, IP, FQDN etc.). All these details are used by main.tf during execution
		ii. Application:  
	c. containing folder for each of the environments like SIT, UAT etc. and 
	d. It contains shell scripts for each of the environment build.
	e. The repo also contains scripts for DB Proxy creation, env & app image creation
	f. 
	g.  
	
**3. All the required software packages (e.g. terraform etc.) are stored in the internal Nexus Repository. The development teams are not allowed to download anything from the internet directly.**
**4.**   
5. sd
6. Ds
7. S
8. S
9. S
10. Sd
11. Sd
12. s  
