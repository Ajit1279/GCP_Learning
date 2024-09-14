#! /bin/bash
gcloud compute instances create mydockermachine --project=test66666666 --zone=us-central1-c --machine-type=n2-standard-8 --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=1006430257477-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=mydockermachine,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240910,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --no-shielded-vtpm --no-shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any
printf "VM details below \n"
gcloud config set project test66666666
gcloud compute instances list

#printf "Please wait while the SSH connection is established \n"
#sleep 5
#gcloud compute ssh --zone "us-central1-c" "mydockermachine" --project "test66666666"
