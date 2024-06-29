#! /bin/bash

# The below line creates SPOT VM with limited Access Scopes. This may reduce the billing
# but you may face errors while accessing certain GCP services. 
#gcloud compute instances create pythontestmachine --project=aiml21 --zone=asia-south1-c --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=955233175770-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=testmachine,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240611,mode=rw,size=10,type=projects/aiml21/zones/asia-south1-c/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

#Use the command below to create Standard VM, but charges are higher
#gcloud compute instances create pythontestmachine --project=aiml21 --zone=asia-south1-c --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=955233175770-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=pythontestmachine,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240617,mode=rw,size=10,type=projects/aiml21/zones/asia-south1-c/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

# Use the below command to create SPOT VM with broader access scopes
gcloud compute instances create pythontestmachine --project=aiml21 --zone=asia-south1-c --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=955233175770-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=pythontestmachine,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240617,mode=rw,size=10,type=projects/aiml21/zones/asia-south1-c/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

printf "VM details below \n"

gcloud compute instances list

printf "Please wait while the SSH connection is established \n"

sleep 10

gcloud compute ssh --zone "asia-south1-c" "pythontestmachine" --project "aiml21"
