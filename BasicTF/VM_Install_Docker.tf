# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

##################################################################################################################
# This script creates a Debian Linux instance and installs docker on it.
##################################################################################################################

resource "google_compute_instance" "mydockermachine" {
  boot_disk {
    auto_delete = true
    device_name = "mydockermachine"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20231115"
      size  = 10
      type  = "pd-standard"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-docker"
  }

  machine_type = "e2-medium"
  name         = "mydockermachine"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/tf-proj-21/regions/asia-south1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "285839563305-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = "asia-south1-c"

  # Please ensure Google APIs are enabled to be able to copy shellscript

  # Install Docker from using shell script.
  metadata_startup_script = "sudo apt-get update; /startup/dockinst.sh"

  # 

}
