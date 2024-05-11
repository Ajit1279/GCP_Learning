from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

job_config = bigquery.QueryJobConfig(
    # Run at batch priority, which won't count toward concurrent rate limit.
    priority=bigquery.QueryPriority.BATCH
)

sql = """
    SELECT name, SUM(number) as total_people
    FROM `bigquery-public-data.usa_names.usa_1910_2013`
    WHERE state = 'TX'
    GROUP BY name, state
    ORDER BY total_people DESC
    LIMIT 20
"""

# Start the query, passing in the extra configuration.
query_job = client.query(sql, job_config=job_config)  # Make an API request.

# Check on the progress by getting the job's updated state. Once the state
# is `DONE`, the results are ready.
query_job = client.get_job(
    query_job.job_id, location=query_job.location
)  # Make an API request.

print("Job {} is currently in state {}".format(query_job.job_id, query_job.state))
