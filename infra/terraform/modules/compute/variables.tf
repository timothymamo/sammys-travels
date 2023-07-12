# # You can also set DIGITALOCEAN_TOKEN env variable
# # Set the variable value in *.tfvars file or use the -var="do_token=..." CLI option
# variable "do_token" {
#   description = "DO API token with read and write permissions."
#   type        = string
#   sensitive   = true
# }

variable "no_instances" {
  description = "The number of droplets to be deployed."
  type        = number
}

variable "region" {
  description = "The region where the Droplet will be created."
  type        = string
}

variable "region_bucket" {
  description = "The region where the Bucket is located. Defaults to Droplet region if empty."
  type        = string
  default     = ""
}

variable "domain" {
  description = "Domain name where the Supabase instance is accessible. The final domain will be of the format `supabase.example.com`"
  type        = string
}

variable "droplet_size" {
  description = "The unique slug that identifies the type of Droplet."
  type        = string
  default     = "s-1vcpu-2gb"
}

variable "droplet_backups" {
  description = "Boolean controlling if backups are made. Defaults to true."
  type        = bool
  default     = true
}

variable "ssh_pub_file" {
  description = "The path to the public key ssh file. Only one of var.ssh_pub_file or var.ssh_keys needs to be specified and should be used."
  type        = string
  default     = ""
}

variable "ssh_keys" {
  description = "A list of SSH key IDs or fingerprints to enable in the format [12345, 123456]. Only one of `var.ssh_keys` or `var.ssh_pub_file` needs to be specified and should be used."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A list of the tags to be added to the default (`[\"supabase\", \"digitalocean\", \"terraform\"]`) Droplet tags."
  type        = list(string)
  default     = []
}

variable "spaces_key" {
  description = "DO Spaces Key."
  type        = string
}

variable "spaces_secret" {
  description = "DO Spaces Secret."
  type        = string
}

variable "google_api" {
  description = "Google Geolocation API key."
  type        = string
}
