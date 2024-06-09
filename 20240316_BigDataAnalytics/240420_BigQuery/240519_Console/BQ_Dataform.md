- References: https://cloud.google.com/dataform/docs
- References: https://cloud.google.com/dataform/docs/overview

- **Introduction:**
  -  Helps you to **transform raw data extracted from source systems** and **loaded into BigQuery** into a **well-defined, tested, and documented suite of data tables**. 
  - Service for data analysts to **develop, test, version control, and schedule complex SQL workflows** for data transformation in BigQuery.
  - **Manage data transformation in the Extraction, Loading, and Transformation (ELT) process** for data integration.
  - Dataform perform the **following data transformation actions:**
    - **Develop and execute SQL workflows** for data transformation.
    - **Collaborate** with team members **on SQL workflow development through Git**.
    - Manage a **large number of tables and their dependencies**.
    - **Declare source data** and manage table dependencies.
    - **Visualization of the dependency tree of your SQL workflow**.
    - **Manage data with SQL code in a central repository**.
    - **Reuse code with JavaScript**.
    - **Test data correctness** with quality tests on source and output tables.
    - **Version control SQL code**.
    - **Document data tables inside SQL code**.
   

- [Data Transformation process in Dataform](https://cloud.google.com/dataform/docs/overview#data-transformation)
  - [**Create Repositories to manage your code**](https://github.com/Ajit1279/GCP_Learning/blob/main/20240316_BigDataAnalytics/240420_BigQuery/240519_Console/BQ_Dataform_Repository.md): Uses [Dataform core](https://cloud.google.com/dataform/docs/dataform-core), an extension of SQL, to write SQLX files in which you define your workflow.
  - **[Link it to third party git provider](https://cloud.google.com/dataform/docs/connect-repository)**: To Support version control   
  - **[Create Workspace for development](https://cloud.google.com/dataform/docs/create-workspace)**: Make changes to the workflows, compile, test, and push them to the main repository through Git.
  - **Develop SQL workflows in a development workspace**: Define and document tables, their dependencies, and transformation logic to build your SQL workflow.
  - [**Compile Dataform core into SQL**](https://cloud.google.com/dataform/docs/overview#compile): It's hermetic to ensure compilation consistency (meaning the same code compiles to the same SQL compilation result every time). 
  - [**Executes the dependency tree**](https://cloud.google.com/dataform/docs/overview#execute): Executes SQL commands, following the order of the dependency tree.
  - **Provides an open source data modeling framework**, consisting of Dataform core and [Dataform CLI](https://cloud.google.com/dataform/docs/use-dataform-cli), that you can use outside Google Cloud.
 
