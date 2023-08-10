resource "google_compute_firewall" "default" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
  source_tags = ["web"]
}
