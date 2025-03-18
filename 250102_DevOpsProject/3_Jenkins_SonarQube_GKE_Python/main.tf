provider "google" {
  project = "devopsongcp"
  region  = "us-central1-a"
}

# Define the latest Debian 12 image
data "google_compute_image" "debian_latest" {
  family  = "debian-12"
  project = "debian-cloud"
}

# Jenkins VM
resource "google_compute_instance" "jenkins" {
  name         = "jenkins-server"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    set -e
    
    # Install Java (required for Jenkins)
    sudo apt update && sudo apt install -y openjdk-17-jdk
    sudo apt install ca-certificates curl gnupg -y
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /etc/apt/keyrings/jenkins.asc > /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/jenkins.asc] http://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt update
    sudo apt install jenkins -y

    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

    sudo apt-get update
    sudo apt-get install -y kubectl

    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    sudo systemctl status jenkins
   EOT
}

# SonarQube VM
resource "google_compute_instance" "sonarqube" {
  name         = "sonarqube-server"
  machine_type = "e2-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_latest.self_link
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  scheduling {
    preemptible       = true
    provisioning_model = "SPOT"
    automatic_restart = false  
  }

  metadata_startup_script = <<EOT
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo docker run -d -p 9000:9000 --name sonarqube sonarqube
  EOT
}

# Firewall Rules
resource "google_compute_firewall" "allow_jenkins_sonarqube" {
  name    = "allow-jenkins-sonarqube"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080", "9000"]
  }

  source_ranges = ["0.0.0.0/0"]
}
