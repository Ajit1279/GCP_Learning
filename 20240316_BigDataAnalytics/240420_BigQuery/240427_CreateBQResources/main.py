from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

# TODO(developer): Set dataset_id to the ID of the dataset to create.
dataset_id = "{}.mydataset".format(client.project)

# Construct a full Dataset object to send to the API.
dataset = bigquery.Dataset(dataset_id)

# TODO(developer): Specify the geographic location where the dataset should reside.
dataset.location = "US"

# Send the dataset to the API for creation, with an explicit timeout.
# Raises google.api_core.exceptions.Conflict if the Dataset already
# exists within the project.
dataset = client.create_dataset(dataset, timeout=30)  # Make an API request.
print("Created dataset {}.{}".format(client.project, dataset.dataset_id))

datasets = list(client.list_datasets())  # Make an API request.
project = client.project

dataset = client.get_dataset(dataset_id)  # Make an API request.

full_dataset_id = "{}.{}".format(dataset.project, dataset.dataset_id)
friendly_name = dataset.friendly_name
print(
    "Got dataset '{}' with friendly_name '{}'.".format(
        full_dataset_id, friendly_name
    )
)

# View dataset properties.
print("Description: {}".format(dataset.description))
print("Labels:")
labels = dataset.labels
if labels:
    for label, value in labels.items():
        print("\t{}: {}".format(label, value))
else:
    print("\tDataset has no labels defined.")

# View tables in dataset.
print("Tables:")
tables = list(client.list_tables(dataset))  # Make an API request(s).
if tables:
    for table in tables:
        print("\t{}".format(table.table_id))
else:
    print("\tThis dataset does not contain any tables.")
  

if datasets:
    print("Datasets in project {}:".format(project))
    for dataset in datasets:
        print("\t{}".format(dataset.dataset_id))
else:
    print("{} project does not contain any datasets.".format(project))

# Update the properties

dataset = client.get_dataset(dataset_id)  # Make an API request.
dataset.description = "My BigQuery Practice Datasets"
dataset.labels = {"color": "green"}
dataset = client.update_dataset(dataset, ["description","labels"])  # Make an API request.

full_dataset_id = "{}.{}".format(dataset.project, dataset.dataset_id)
print(
    "Updated dataset '{}' with description and labels '{}'.".format(
        full_dataset_id, dataset.description
    )
)

##########################################################################################
# Now Let's create Partitioned Tables
############################################################################################
#table_id = your_fully_qualified_table_id
table_id = "{}.mypartitiontable".format(full_dataset_id)
schema = [
    bigquery.SchemaField("name", "STRING"),
    bigquery.SchemaField("post_abbr", "STRING"),
    bigquery.SchemaField("date", "DATE"),
]
table = bigquery.Table(table_id, schema=schema)
table.time_partitioning = bigquery.TimePartitioning(
    type_=bigquery.TimePartitioningType.DAY,    # The table is partitioned by day
    field="date",  # name of column to use for partitioning
    expiration_ms=1000 * 60 * 60 * 24 * 90,
)  # 90 days

table = client.create_table(table)

print(
    f"Created table {table.project}.{table.dataset_id}.{table.table_id}, "
    f"partitioned on column {table.time_partitioning.field}."
)

############################################################################################
# Now let's create views
#######################################################################################
view_id = "{}.myview".format(full_dataset_id)
#source_id = "my-project.my_dataset.my_table"
source_id = table_id
view = bigquery.Table(view_id)

# The source table in this example is created from a CSV file in Google
# Cloud Storage located at
# `gs://cloud-samples-data/bigquery/us-states/us-states.csv`. It contains
# 50 US states, while the view returns only those states with names
# starting with the letter 'W'.
view.view_query = f"SELECT name, post_abbr FROM `{source_id}` WHERE name LIKE 'W%'"

# Make an API request to create the view.
view = client.create_table(view)
print(f"Created {view.table_type}: {str(view.reference)}")
