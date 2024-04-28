resource "google_bigquery_dataset" "default" {
  dataset_id                      = "mytfdataset"
  default_partition_expiration_ms = 7200000  # 2 hours
  default_table_expiration_ms     = 7200000  # 2 hours 
  description                     = "dataset created using terraform"
  location                        = "US"
  max_time_travel_hours           = 48 # 2 day

  labels = {
    billing_group = "accounting",
    pii           = "non-sensitive"
  }
}
