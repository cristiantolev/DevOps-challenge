resource "google_compute_instance" "vm-jenkins" {
  name         = "jenkins"
  machine_type = "e2-standard-2"
  zone         = "europe-west3-a"

  tags = ["web"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2204-jammy-v20230612"
    }
  }



  metadata = {
    ssh-keys = join("\n", [for key in var.ssh_keys : "${key.user}:${key.publickey}"])
 
# Install Jenkins
     startup-script = <<-EOT
       #!/bin/bash
       sudo apt update
       wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
       sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
       sudo apt-get update
       sudo apt-get install -y jenkins
       EOT
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}
