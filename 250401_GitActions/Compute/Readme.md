- References: https://www.youtube.com/watch?v=psm98noY-JM
- References: https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions

- Create a new project (optional step but it is easier to clean-up the resources quickly)

- Enable various services

       gcloud  
-  
  
- Create a yaml file ([create-gcp-instance.yaml](https://github.com/Ajit1279/GCPStaging/blob/main/.github/workflows/create-gcp-instance.yml)) file in the root/.github/workflow directory of the github repository

- Setting up Identity Federation for GitHub Actions
  
  - Create Workload Identity Pool 

        gcloud iam workload-identity-pools create "my-pool" \
        --project="gitops-455207" \
        --location="global" \
        --display-name="My Workload Identity Pool" 

  
  - Create an OIDC provider:

        gcloud iam workload-identity-pools providers create-oidc "my-provider" \
        --project="gitops-455207" \
        --location="global" \
        --workload-identity-pool="my-pool" \
        --display-name="My OIDC Provider" \
        --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
        --issuer-uri="https://token.actions.githubusercontent.com"

    
- sd
- sd
- s
- ds
- ds
- ds
- d
- sd
- sd
