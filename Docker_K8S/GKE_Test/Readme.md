Create GKE Cluster
- Login to Google Cloud Console and activate cloud shell

- Usually kubectl (tool for controlling Kubernetes clusters in general.) is pre-installed. Type the below command to check the verion.

      kubectl version

- If the above command returns erro, install Kube Control, 

        sudo apt-get install kubectl
  
- Let's create a cluster referring the [documentation](https://cloud.google.com/sdk/gcloud/reference/container/clusters/create)

        gcloud container clusters create my-cluster --machine-type n1-standard-2 --num-nodes 3 --zone us-central1-a --disk-size 10GB 
    
- Type the command to check the nodes

        kubectl get node
  
- Give admin permissions

        kubectl create clusterrolebinding cluster-admin-binding \
        --clusterrole=cluster-admin \
        --user=<GOOGLE-EMAIL-ACCOUNT>
   
- Next steps can be performed based on your requirements
