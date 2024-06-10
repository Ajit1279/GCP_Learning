- Reference: https://cloud.google.com/dataform/docs/create-workspace

- It involves:
  - [Creating workspace](https://cloud.google.com/dataform/docs/create-workspace#create-workspace)
  - [Initialize the first development workspace in a Dataform repository](https://cloud.google.com/dataform/docs/create-workspace#initialize-workspace)
  - [Delete workspace](https://cloud.google.com/dataform/docs/create-workspace#delete-workspace) (if required).  


- **Creating a workspace**
  - When you create new repository for the first time, Dataform prompts you to initialize the development workspace with a set of configuration files
  - It contains various directories and files: _definitions/_, _includes/_, _dataform.json_, _package.json_, _definitions/sample.sqlx_ 
  - Select the repository where you want to create the new development workspace.
    
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7d5f55bc-fc2a-41af-801f-b4a2eab334fb)

  - Provide the workspace id and click create

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/b40e1b8d-ae60-4d96-af79-0614c6b31e3a)

  -  If you click on the workspace, it takes you to the new screen

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/0b5434a1-94ef-42af-941d-0493c0b0c555)


  - Click on the Initialize workspace. It's initialized with the default configuration

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/57b70703-5746-4a44-ab6a-a13f4f20b1ff)

  - [Create custom compilation variables](https://cloud.google.com/dataform/docs/configure-dataform#create-compilation-variables)
    e.g. add executionSetting: dev

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/60facaca-1a38-4d58-bd50-9b1eb147db2d)
    
  - Click on "Commit 4 changes"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/51c699f9-6cb4-4fc7-a3ce-a96ed3e8a969)


  - Select files to be committed and click "Commit all files"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/76b98751-8a1d-4a5b-b6b8-6221da3f3551)
  

  - Then click on "Push to Remote Branch"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5176b166-3246-4434-aaeb-8833bc4110cb)


  - A link to create a PR in repository appears

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/43c25142-e796-4fa7-9152-27336432aac9)


    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/46342b78-493d-444d-8be2-9135bd9e94bb)


  - Create a pull request in GitHub

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5dc0196a-9394-4285-84c2-9f52ecdce9e5)

  - Pull request is created

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/2fed866f-dce4-4e0f-829e-a91f554c90cd)

  - Click on "merge pull request"

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5abfa203-b529-4ea8-bfb2-2bcf1546939e)
   
  - All the files are available in the github

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/5e123081-4aa4-4002-8035-30b2666d9ad0)

  
