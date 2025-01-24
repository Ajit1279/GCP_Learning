resource "google_storage_bucket" "my-bucket" {
  name                     = "apk-githubdemo-bucket"
  project                  = "devops1279"
  location                 = "ASIA-SOUTH1"
  force_destroy            = "true"
  public_access_prevention = "enforced"
  }
  
