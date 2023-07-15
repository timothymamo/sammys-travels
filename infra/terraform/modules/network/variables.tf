# # You can also set DIGITALOCEAN_TOKEN env variable
# # Set the variable value in *.tfvars file or use the -var="do_token=..." CLI option
variable "do_token" {
  description = "DO API token with read and write permissions."
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The region where the Droplet will be created."
  type        = string
}

variable "domain" {
  description = "Domain name where the Supabase instance is accessible. The final domain will be of the format `supabase.example.com`"
  type        = string
}

variable "tag" {
  description = "A tag to be added to the default (`[\"sammys-travels\", \"digitalocean\", \"terraform\"]`) Droplet tags."
  type        = string
  default     = ""
}

variable "enable_ssh" {
  description = "Boolean enabling connections to droplet via SSH by opening port 22 on the firewall."
  type        = bool
  default     = false
}

variable "ssh_ip_range" {
  description = "An array of strings containing the IPv4 addresses and/or IPv4 CIDRs from which the inbound traffic will be accepted for SSH. Defaults to ALL IPv4s but it is highly suggested to choose a smaller subset."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
