resource "google_bigquery_dataset" "default" {
  dataset_id                      = "mytfdataset"
  default_partition_expiration_ms = 7200000  # 2 hours
  default_table_expiration_ms     = 7200000  # 2 hours 
  description                     = "dataset created using terraform"
  location                        = "US"
  max_time_travel_hours           = 48 # 2 day

  labels = {
    billing_group = "testaccount",
    pii           = "non-sensitive"
  }
}

# Update the user, group, or service account provided by the members argument with the appropriate principals for your organization.
data "google_iam_policy" "default" {
  binding {
    role = "roles/bigquery.dataOwner"
    members = [
      "user:ajit1279.aiml@gmail.com",
    ]
  }
  binding {
    role = "roles/bigquery.admin"
    members = [
      "user:ajit1279.aiml@gmail.com",
    ]
  }
#  binding {
#    role = "roles/bigquery.user"
#    members = [
#      "group:analysts@altostrat.com",
#    ]
#  }
  binding {
    role = "roles/bigquery.dataViewer"
    members = [
      "serviceAccount:bqservacct1@mybqproj0427.iam.gserviceaccount.com",
    ]
  }
}

resource "google_bigquery_dataset_iam_policy" "default" {
  dataset_id  = google_bigquery_dataset.default.dataset_id
  policy_data = data.google_iam_policy.default.policy_data
}

resource "google_bigquery_table" "default" {
  dataset_id          = google_bigquery_dataset.default.dataset_id
  table_id            = "mytftable"
  deletion_protection = false # set to "true" in production

  schema = <<EOF
[
  {
    "name": "ID",
    "type": "INT64",
    "mode": "NULLABLE",
    "description": "Item ID"
  },
  {
    "name": "Item",
    "type": "STRING",
    "mode": "NULLABLE"
  }
]
EOF

}
