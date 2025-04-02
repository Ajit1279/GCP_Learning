- References: https://cloud.google.com/sdk/gcloud/reference/iam/workload-identity-pools/providers/create-oidc
- References: https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions

- Create a new project (optional step but it is easier to clean-up the resources quickly) 

- Enable various services

       gcloud services enable iamcredentials.googleapis.com \
       compute.googleapis.com
                              

- Setting up Identity Federation for GitHub Actions
  
  - Create Workload Identity Pool 

        gcloud iam workload-identity-pools create "github-pool" \
        --project="gitaction-1234" \
        --location="global" \
        --display-name="My Github Workload Identity Pool"

    ![image](https://github.com/user-attachments/assets/bf870e72-b964-4f4b-b984-126a8dc63851)
  
  - Create an OIDC provider:

        gcloud iam workload-identity-pools providers create-oidc github-provider \
           --location="global" \
           --workload-identity-pool="github-pool" \
           --issuer-uri="https://token.actions.githubusercontent.com/" \
           --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner" \
           --attribute-condition="assertion.repository == 'Ajit1279/GCP_Learning'"


       ![image](https://github.com/user-attachments/assets/f6291b80-ff76-47f9-8fbb-adae94cc1e13)

       ![image](https://github.com/user-attachments/assets/0db38aeb-5a61-4e52-9128-11a57416a729)

    - Please note the value from the github-pool. This will need to be added in the yaml file for authentcating: projects/337168148611/locations/global/workloadIdentityPools/github-pool/providers/github-provider

- Create service account and assign roles:

       gcloud iam service-accounts create gitaction-sa --display-name="Service Account for Github Actions"

- List the service accounts and note down the newly create service account for github action (gitaction-sa@gitaction-1234.iam.gserviceaccount.com)

       gcloud iam service-accounts list

   ![image](https://github.com/user-attachments/assets/c70574fd-eece-4aeb-afeb-830b95b6b01a)
    
  
- Assign required roles to this account: Workload Identity User, Service Account User, Compute Admin, Service Account Token creator

   ![image](https://github.com/user-attachments/assets/77d57454-60fb-4810-8276-d442b15914fc)


- Additionally please run the command:

      gcloud iam service-accounts add-iam-policy-binding gitaction-sa@gitaction-1234.iam.gserviceaccount.com \
           --member="principalSet://iam.googleapis.com/projects/337168148611/locations/global/workloadIdentityPools/github-pool/attribute.repository/Ajit1279/GCP_Learning" \
           --role="roles/iam.serviceAccountTokenCreator"


   ![image](https://github.com/user-attachments/assets/38c107c0-a414-4e2e-8e6d-8b5a98148a49)

- Create a yaml file say create-gcp-instance.yaml in .[github/workflows](https://github.com/Ajit1279/GCP_Learning/tree/main/.github/workflows) directory within the github repository

- Once committed in the github, the job is triggered automatically. The status can be verified in "actions

- The job ran successfully. Please refer the logs below:

   ![image](https://github.com/user-attachments/assets/e4ca2a15-5bc0-432f-923d-fc1cfbad6996)


- The VM instance has been created successfully

   ![image](https://github.com/user-attachments/assets/ccb153b1-05f5-49a6-903c-ef0c02bee32a)

   ![image](https://github.com/user-attachments/assets/0b4213b4-f551-4871-9a38-b1fb0459221f)


  
