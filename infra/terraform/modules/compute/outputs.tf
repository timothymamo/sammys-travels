output "ipv4_address" {
  description = "The IPv4 address assigned to the droplet."
  value       = digitalocean_droplet.this.*.ipv4_address
}
