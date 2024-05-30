- Reference: https://cloud.google.com/bigquery/docs/spark-procedures

- Objective is to **create and run Spark stored procedures in BigQuery** written in Python, Java, and Scala
- Apache Spark™ : **Multi-language engine** for executing data engineering, data science and machine learning on **single-node machines or clusters**.

- **Steps:**
  - Enable the BigQuery Connection API (if not done already)
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a6143448-e6b8-4c5a-a9ee-5b15f054ab87)

  - Go to BigQuery >> BigQuery Studio >> ADD >> Connections to External data sources
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/f92c60cb-c798-4a21-b162-6f80698ee111)

  - Select Apache Spark in Connection Type
  
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/40bc4756-007e-4695-9261-6be41f46e982)

  - Fill-up the remaining details and then click on "Create Connection"
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/e627a8a3-60c0-4618-a2c2-5d32fc9287e4)

  
  - A message is displayed when the connection is created

    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7939363f-5e4d-4d37-8bb8-1ae647b71f34)

  - Go to the connection
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/84347134-7642-4c3c-b59e-86be16f3f78e)

  - [Create a stored Procedure for Apache Spark](https://cloud.google.com/bigquery/docs/spark-procedures)
    - In the PySpark editor, click on the More >> PySpark Options

      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4de64472-a69b-4738-aaaf-0a5fced8e75c)

      
    - Select appropriate values in dropdown and click SAVE
 
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/eee58f06-becd-4068-9465-3f9430cb26cf)

    - Type the below code in the editor
      
      CREATE OR REPLACE PROCEDURE mybqproj0427.my_dataset.spark_proc()
      WITH CONNECTION `projects/mybqproj0427/locations/us-central1/connections/Spark-BQ-Test-Connection`
      OPTIONS(engine="SPARK", runtime_version="1.1")
      LANGUAGE PYTHON AS R"""
      from pyspark.sql import SparkSession

      spark = SparkSession.builder.appName("spark-bigquery-demo").getOrCreate()

      # Load data from BigQuery.
      words = spark.read.format("bigquery") \
      .option("table", "bigquery-public-data:samples.shakespeare") \
      .load()
      words.createOrReplaceTempView("words")

      # Perform word count.
      word_count = words.select('word', 'word_count').groupBy('word').sum('word_count').withColumnRenamed("sum(word_count)", "sum_word_count")
      word_count.show()
      word_count.printSchema()

      # Saving the data to BigQuery
      word_count.write.format("bigquery") \
      .option("writeMethod", "direct") \
      .save("wordcount_dataset.wordcount_output")
      """

    - There's a syntax error:
      ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/4c4a70c3-07bb-40de-85a6-b8005f6d1b86)
    

- ds
- ds
- ds
- ds
- d
- sd
- sd
- s
- ds
- ds
- ds 
