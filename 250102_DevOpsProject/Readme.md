- Reference: https://dev.to/prodevopsguytech/devops-project-production-level-cicd-pipeline-project-1iek

- Create VM instance on GCP

        gcloud compute instances create mylocalmachine --project=devops-446607 --zone=us-central1-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --no-restart-on-failure --maintenance-policy=TERMINATE --provisioning-model=SPOT --instance-termination-action=STOP --service-account=807547610042-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=mylocalmachine,image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20241219,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

  
- sd
- sd
- s
- ds
- ds
- d
- sd
- sd
- sd
- sd
- sd
- s
