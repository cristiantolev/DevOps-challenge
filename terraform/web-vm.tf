resource "google_compute_instance" "web" {
  count        = 2
  name         = "web-${count.index}"
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
 
// install Nginx 
    startup-script = <<-EOT
      #!/bin/bash
      sudo apt update
      sudo apt install nginx
      sudo systemctl start nginx
      sudo systemctl enable nginx
      EOT

  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}
