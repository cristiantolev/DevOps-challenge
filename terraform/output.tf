locals {
  instance_ips = [for inst in google_compute_instance.web : inst.network_interface.0.access_config.0.nat_ip]
}

output "instances_IPs" {
  value = local.instance_ips
}