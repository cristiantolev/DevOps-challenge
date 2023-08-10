output "instances-IP's" {
    description = "Public IP of the Jenkins VM"
    value = google_compute_instance.web.network_interface.0.access_config.0.nat_ip
}