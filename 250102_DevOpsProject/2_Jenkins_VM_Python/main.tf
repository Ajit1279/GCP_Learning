resource "google_compute_instance" "example" {
  name         = "my-vm"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a" 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = "default"
  }

  tags = ["http-server", "vm"]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y python3",
      "echo 'print(\"Hello, World!\")' > hello.py",
      "python3 hello.py",
    ]
  }
}
