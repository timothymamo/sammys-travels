output "lb_ip" {
  description = "The Reserved IP assigned to the droplet."
  value       = digitalocean_loadbalancer.public.ip
}
