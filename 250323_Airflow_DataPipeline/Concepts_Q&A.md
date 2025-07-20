Concepts
- A DAG defines what needs to be done and in what order.
  - "Directed": This means there's a clear, one-way flow of execution. Think of it like a roadmap with arrows – you can only go in the direction of the arrows
  - "Acyclic": This means there are no "cycles" or loops in your workflow.

- Tasks: the individual steps or actions your workflow performs are called Tasks.

- Operator: Think of an Operator as a blueprint or a template for a specific type of work.  e.g. PythonOperator to run a Python function as a task, BashOperator lets you execute a shell command

- Define Dependencies: define the order and relationships between Tasks using bit-shift operators (>> and <<) or the set_downstream/set_upstream methods.

- Scheduler: It's job is to orchestrate and decide what needs to run and when. But it delegates the actual "doing" of the work.

- Executor: The component in Airflow responsible for actually executing the individual Task Instances
  - Sequential Executor: This is the simplest (and default) executor, mainly used for testing. It runs tasks one after another, sequentially, on the same machine as the Scheduler. No concurrency or distribution here.
  - Local Executor: This executor runs tasks concurrently (in parallel) on the same machine as the Scheduler, using multiple processes. It's good for a single, powerful machine.
  - Celery Executor / Kubernetes Executor: These are the more advanced and commonly used executors for production environments. They allow Airflow to distribute tasks across a cluster of worker machines.The Celery Executor uses a message queue (like RabbitMQ or Redis) to send tasks to a pool of Celery workers.The Kubernetes Executor dynamically spins up a new Kubernetes pod for each task, running it in an isolated environment.

- When a task fails, you generally want two things to happen:
  - Retry: Give the task another chance to succeed, as some failures might be transient (e.g., a temporary network glitch). E.g. retries=3 and retry_delay=timedelta(minutes=5)
  - Notify: Alert someone (like you!) that something went wrong. e.g. email_on_failure, on_failure_callback

- Airflow UI: The primary way users interact with Airflow for monitoring, management, and triggering is through the UI. The Airflow UI is served by a component called the Airflow Webserver.

- Airflow Webserver: The Webserver is essentially a Flask application that constantly communicates with the metadata database to fetch information about DAGs, DAG Runs, Task Instances, logs, connections, variables, and so on.

- XComs (short for Cross-Communications): Airflow's built-in, simpler mechanism specifically designed for passing information from one task to the downstream task(s) usually within the same DAG Run. Think of them as a key-value store specific to a DAG Run, where tasks can "push" data and other tasks can "pull" data. XComs are stored in the Airflow metadata database. This is why they are persistent across task retries and even across different worker machines (if you're using a distributed executor like Celery or Kubernetes). XComs are not designed for passing large datasets (like entire CSV files, Pandas DataFrames, or large JSON objects).

- Airflow Connections: These are used to store connection details for external systems (databases, S3 buckets, APIs, etc.). Instead of writing psycopg2.connect(host='my_db', user='admin', password='password'), you'd use an Airflow Operator (e.g., PostgresOperator) and tell it which postgres_conn_id to use. Connections can be managed via the Airflow UI

- Airflow variables: These are used to store arbitrary key-value pairs of non-sensitive or less sensitive configuration data that might change frequently. Examples include API endpoints, feature flags, or batch sizes.Providers and hooks: Allow Airflow to integrate directly with the external secret managers.When an operator needs a connection, Airflow asks the configured secret manager for the credentials associated with a given conn_id or variable_key at runtime.

- DAGs Folder: Airflow has a configuration parameter, dags_folder, which points to a specific directory on the filesystem where your DAG Python files reside. The scheduler periodically scans this directory, looking for new or updated .py files. It parses that Python file to identify all the DAG objects defined within and "registers" the DAG with Airflow. Please note: The DAG definition (the Python file itself) is NOT stored or versioned in the Airflow metadata database. The database only stores the metadata generated by the DAGs' execution. The DAG Python files can be version controlled using standard tools like Git.

- Some best practices for structuring your DAGs and related code:
  - Keep DAG Files Lean: Should primarily contain the DAG definition (the DAG() object) and the task definitions.
  - Avoid complex business logic, heavy imports, or data transformations directly in the global scope of your DAG file
  - Modularize and Externalize Reusable Code:  The helper modules can be placed in a directory often called include, plugins, or a custom Python package
  - Organize with Subfolders: If you have many DAGs, consider organizing them into logical subfolders within your dags_folderIn larger data ecosystems, it's common to have a pipeline defined in one DAG, and once that's complete, it should kick off another entirely separate pipeline. Airflow provides specific mechanisms for this "cross-DAG" or "inter-DAG" communication and orchestration.

- TriggerDagRunOperator: Allows you to explicitly trigger another DAG from within your current DAG. Use it when you want your current DAG to initiate a run of another DAG.  

- ExternalTaskSensor: This operator allows a task in your current DAG to wait for the completion of a specific task (or an entire DAG) in another DAG. Use it when you want your current DAG to wait for another DAG (or a task within it) to finish. sdsdsdsds   
 

================================== Q & A =======================
- Imagine you need to run a series of tasks, one after another, and some tasks only run if the previous one succeeds. How would you generally approach this problem, and where do you think Airflow fits in?
- Could you elaborate on what a DAG is in the context of Airflow?
- What does "Directed Acyclic Graph" actually mean for someone using Airflow? And what are the fundamental building blocks inside a DAG that represent the individual steps of your workflow?
- When we say "Directed Acyclic Graph," what does "Directed" signify regarding the flow of your processing? And what does "Acyclic" mean for how you design your workflow?
- Why is being "Acyclic" important?
- You mentioned the DAG processes data. What are the individual, atomic units of work within a DAG called in Airflow? And what are the different types of these units that allow you to, say, run a Python script, execute a SQL query, or send an email?
- Finally, how do you define the "dependencies" you mentioned earlier between these individual units of work within the DAG, ensuring they run in the correct order?
- A DAG defines what needs to be done and in what order. But how does Airflow actually run this workflow?
- What happens when your DAG is triggered, either on a schedule or manually?
- What are the terms Airflow uses to describe a specific execution of your entire DAG, and the specific execution of an individual task within that DAG?
- What does Airflow call a specific instance of your entire DAG running from start to finish?And within that specific instance, what does Airflow call a specific attempt to run Task A, Task B, or Task C?What component in Airflow is primarily responsible for deciding when to run these DAGs and tasks?What is the difference between a DAG and a DAG Run?
- Why is it important to distinguish between the two?
- What component in Airflow is responsible for actually executing the individual Task Instances?
- How does Airflow handle running many tasks concurrently or distributing them across multiple machines?
- Imagine a task fails in your DAG. What mechanisms does Airflow provide to handle these failures, perhaps by retrying the task or sending a notification?
- What are some common parameters you'd set in your DAG or Task definition to manage this?
- You have a critical task that downloads data, and it sometimes fails due to network issues. You want it to try up to 5 times, waiting 1 minute between each attempt, and if it still fails after all retries, you want to receive an email. How would you configure this task?
- Where does the Airflow store the metadata information about your DAGs, DAG Runs, Task Instances, and their states persistently?
- You've used Airflow in your job. How do you interact with it?
- How do you typically monitor your DAGs, trigger them manually, view logs, or manage connections and variables?
- What Airflow component provides this graphical interface?
- We've discussed how tasks run independently. But what if one task needs to pass a small piece of information (like a file path, a record count, or an ID) to a downstream task? For example, if Task A downloads a file and Task B needs the exact path to that downloaded file. How would you handle this communication between tasks in Airflow?
- What is the Airflow-specific mechanism for this?
- What are the limitations or best practices for using this mechanism?
- You have sensitive information like database credentials, API keys, or cloud service access tokens, how does Airflow recommend managing and storing these securely?
- What are the mechanisms available, and why is it generally a bad idea to hardcode them directly into your DAG files?
- Have you written DAGs before? If yes, when you develop a new DAG or modify an existing one, how does Airflow "discover" or load these Python files?
- What are some best practices for structuring your DAG files and folders within your Airflow environment to keep things organized and performant?
- What are some best practices you would follow for structuring your DAG files and folders within that dags_folder?
- How would you make sure your DAGs are performant during parsing?
- Sometimes, you have a situation where you need one DAG to trigger another DAG, or you need to monitor the completion of a DAG before another one starts. How would you achieve this "cross-DAG" or "inter-DAG" communication and orchestration in Airflow?
- What are the operators typically used for this?
