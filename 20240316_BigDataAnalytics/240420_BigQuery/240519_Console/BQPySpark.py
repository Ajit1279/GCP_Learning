CREATE OR REPLACE PROCEDURE
	`mybqproj0427.testpyspark.spark_proc`()
WITH CONNECTION `mybqproj0427.us-central1.Spark-BQ-Test-Connection` OPTIONS (engine='SPARK', properties=[])
	LANGUAGE PYTHON AS r"""
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
""";
