resource "google_storage_bucket" "my-bucket" {
  name                     = "apk-githubdemo-bucket"
  project                  = "DevOps"
  location                 = "Asia"
  force_destroy            = "true"
  public_access_prevention = "enforced"
  }
  
