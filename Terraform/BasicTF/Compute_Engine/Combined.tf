resource "google_compute_autoscaler" "default" {
  provider = google-beta
  name     = "my-autoscaler"
  zone     = "us-central1-c"
  target   = google_compute_instance_group_manager.default.id

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    scaling_schedules {
      name                  = "every-weekday-morning"
      description           = "Increase to 2 every weekday at 7AM for 12 hours."
      min_required_replicas = 2
      schedule              = "0 7 * * MON-FRI"
      time_zone             = "Asia/Kolkata"
      duration_sec          = 43200
    }
  }
}
# [END compute_autoscale_schedule]

resource "google_compute_instance_template" "default" {
  name = "my-instance-template"
  machine_type   = "e2-medium"
  can_ip_forward = false

  tags = ["tag1", "tag2"]

  disk {
    source_image = data.google_compute_image.debian_11.id
  }

  network_interface {
    network = "default"
  }

  metadata = {
    name = "value"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}


resource "google_compute_instance_group_manager" "default" {

  name = "my-igm"
  zone = "us-central1-c"

  version {
    instance_template = google_compute_instance_template.default.id
    name              = "primary"
  }

  base_instance_name = "autoscaler-sample"
}

data "google_compute_image" "debian_11" {

  family  = "debian-11"
  project = "debian-cloud"
}
# [END compute_autoscaler_instance_group_parent_tag]
#------------------------------------------------------------------------------------
# [START compute_service_account_for_instances_parent_tag]
# [START iam_service_account_for_vm]
resource "google_service_account" "default" {
  account_id   = "compute-service-account-id"
  display_name = "Compute Service Account"
}
# [END iam_service_account_for_vm]

# [START compute_instance_run_as_service_account]
resource "google_compute_instance" "default" {
  name         = "autoscaler-sample"
  machine_type = "n1-standard-1"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts with `cloud-platform` scope with
    # specific permissions granted via IAM Roles.
    # This approach lets you avoid embedding secret keys or user credentials
    # in your instance, image, or app code
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
# [END compute_instance_run_as_service_account]
# [END compute_service_account_for_instances_parent_tag]
