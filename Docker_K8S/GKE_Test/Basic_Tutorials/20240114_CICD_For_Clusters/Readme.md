- Clone git repository: git clone https://github.com/GoogleCloudPlatform/cloud-deploy-tutorials
  
- Change into directory and set-up workspace: cd cloud-deploy-tutorials/tutorials/e2e-gke && cloudshell workspace .
  
- **Deploy Infrastructure:**
  - Run **./setup.sh** to deploy three GKE clusters with the names: test, staging, prod.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d62fcac3-c9b5-4f22-8584-10faa8668dec)

  - It takes approx 10 min to complete and displays the below message when completed
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/cb9ddb73-135a-4599-a0e2-a7b20860b935)

  - To confirm the resources are properly deployed, run the command: gcloud container clusters list
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6ba48f54-7022-4b35-a931-03780047a94a)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e7a9df3b-c883-4873-9f66-fcf70698eacb)

  - The setup.sh also creates Google Cloud Artifact Registry which will be used in subsequent steps to store docker images:

  - 


- **Build an Application**
  - As part of this tutorial, a sample application from the Skaffold (a leading open-source CD toolset). GitHub repository is available from your Cloud Shell instance, in the web directory.
  - The web directory contains **skaffold.yaml**, which contains instructions for skaffold to build a container image for your application. 
  - Run the following command to run the container images
        cd web && skaffold build \
            --interactive=false \
            --default-repo $(gcloud config \
            get-value \
            compute/region)-docker.pkg.dev/modular-citron-402808/web-app \
            --file-output artifacts.json \
            && cd ..  

  - Once completed, it'll display
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/77277039-4342-4bd3-b131-2836628f701e)

  - To confirm the container images built by skaffold were uploaded to the container image registry properly.
      gcloud artifacts docker images \
        list $(gcloud config get-value \
        compute/region)-docker.pkg.dev/$(gcloud \
        config get-value \
        project)/web-app \
        --include-tags --format yaml
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/539aed41-f523-4bc2-81c4-eb25b0ff2d3b)

  - Those can be viewed in Artifacts Registry Repositiry in Console as well.
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/56ef22c0-7d72-4dee-a173-547a53d53ca1)


- **Create Delivery Pipeline:**
  - Cloud Deploy uses YAML files to define delivery-pipeline and target resources.
    https://github.com/Ajit1279/GCP_Learning/blob/main/Docker_K8S/GKE_Test/Basic_Tutorials/20240114_CICD_For_Clusters/delivery-pipeline.yaml
  - Run the below command to create resources using the delivery-pipeline.yaml file:
      gcloud deploy apply \
        --file=clouddeploy-config/delivery-pipeline.yaml 
  - It displays the message:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a6dca0dd-9e04-48a8-a147-1a3681941f02)

  - Verify delivery pipeline is created: target represents a GKE cluster where an application can be deployed as part of a delivery pipeline.
    gcloud deploy delivery-pipelines \
    describe web-app
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/9a22f034-c525-46d5-a200-bdf94938768c)

  - Create the test "target" (GKE cluster where app needs to be deployed) by applying a YAML file to Cloud Deploy
    gcloud deploy apply --file \
    clouddeploy-config/target-test.yaml
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b21f743e-f94f-46c5-ae72-9c74851f2d2c)

  - Verify the target was created
      gcloud deploy targets describe \
    test --delivery-pipeline=web-app
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/677d41cb-e00d-4c0a-8cfd-831c98e8e1b0)

    The output can also be seen in Cloud Console:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f9acd2c8-1236-4788-9cd6-fd0bc9e9a73c)

  - Similarly create staging and production targets
    - staging: gcloud deploy apply --file \
    clouddeploy-config/target-staging.yaml 
    - prod: gcloud deploy apply --file \
    clouddeploy-config/target-prod.yaml
    - Verify: gcloud deploy targets list
    - The details are also displayed in Cloud Console:
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b91113e4-a58e-4226-98ea-5fbdd87555d5)


- **Create a Release**
  - **Cloud Deploy release**
    - Secific version of one or more container images associated with a specific delivery pipeline.
    - Promoted through multiple targets (the promotion sequence)
    - Run the following command to create the release.
      gcloud deploy releases create \
        web-app-001 \
        --delivery-pipeline web-app \
        --build-artifacts \
        web/artifacts.json --source web/
      
    - To confirm the release has been created, run command:
      gcloud deploy releases list \
    --delivery-pipeline web-app \
    --format \
    "yaml(targetRenders, targetArtifacts)"
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f75ba339-4b17-4f8b-a8a0-2d391e08b202)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b3b267bc-408e-4ae0-9d1f-f4a6bcad19d4)

- **Promote your application**
  - To confirm your test target has your application deployed, run the command:
    gcloud deploy rollouts list \
    --delivery-pipeline web-app \
    --release web-app-001
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1ba7a5f9-f054-4099-b78e-4549bf16521c)

  - To confirm your application was deployed to your test GKE cluster, run the following command:
    kubectx test kubectl get pods -n web-app
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/13b7ba76-7faf-41ea-a4d3-c407e1883b75)
 
  - To promote application to staging target, run the command:
      gcloud deploy releases promote \
    --delivery-pipeline web-app \
    --release web-app-001
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/41aa581a-a376-4afe-9614-e52206704e9a)

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4b609388-8974-4616-b1d3-65e15a69bdd9)

  - To confirm your application has been promoted to the staging target, run the following command:
    gcloud deploy rollouts describe \
    --delivery-pipeline web-app \
    --release web-app-001 \
    web-app-001-to-staging-0001 
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b7740bfb-8353-41da-ae48-b660c5a7844d)

  - To confirm your application was deployed to your staging GKE cluster, run the following commands in your Cloud Shell:
    kubectx staging
    kubectl get pods -n web-app

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d00a9297-a946-4f1e-a351-c0400aceda7e)

- **approvals**
  - Look at targets that require approvals before promotions can complete to protect production and sensitive targets
  - Run the command to check requireApproval parameter:
      gcloud deploy targets describe \
      prod --delivery-pipeline web-app --region=us-central1
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b3e3df31-2cc7-4375-9b0a-e4c164274cda)

  - Run the command to promote application to prod: gcloud deploy releases promote \
    --delivery-pipeline web-app \
    --release web-app-001
    As shown below, it prompts user to confirm the deployment
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e277c06a-ee26-4f3f-8f8b-be5b71f09020)

  - The rollout is pending approval
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e8c368bd-29e2-49b6-85d2-88e5a86d510d)

  - Run the command: gcloud deploy rollouts describe --delivery-pipeline web-app --release web-app-001 web-app-001-to-prod-0001 --region=us-central1
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2404eaa6-eca3-468b-9885-16829db31d64)

  - Create a user with the proper IAM roles that can approve this promotion to your prod target.
    - Create a new service account: _gcloud iam service-accounts create pipeline-approver --display-name 'Web-App Pipeline Approver'_ 
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/d88d5c9a-a070-4ac7-a75d-a5ffc83bd43a)

    - Run the command to verify the service account is created and note down the email address, which is required in next step
      gcloud iam service-accounts list
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/27108fca-0d8a-453d-8d8a-fbfbfb56b12e)

    - email address is pipeline-approver@modular-citron-402808.iam.gserviceaccount.com
    - Add approval permissions to service account:
      gcloud projects \
       add-iam-policy-binding \
       modular-citron-402808 \
       --member=serviceAccount:pipeline-approver@modular-citron-402808.iam.gserviceaccount.com \
       --role=roles/clouddeploy.approver 

  - To approve and promote to production run the command:
    gcloud deploy rollouts approve \
    web-app-001-to-prod-0001 \
    --delivery-pipeline web-app \
    --release web-app-001
 ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4c55219c-9461-491b-af91-029d653599b9)

  - Run the command to verify if promotion is complete: gcloud deploy rollouts describe --delivery-pipeline web-app --release web-app-001 web-app-001-to-prod-0001 --region=us-central1
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2c00f7db-eaaf-4497-a794-6fbc52b89b52)

  - You can also run command: kubectx prod kubectl get pod -n web-app
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/35a66131-b28f-4b56-8f66-bbc8f2d80c19)
 
