# # You can also set DIGITALOCEAN_TOKEN env variable
# # Set the variable value in *.tfvars file or use the -var="do_token=..." CLI option
variable "do_token" {
  description = "DO API token with read and write permissions."
  type        = string
  sensitive   = true
}

# You can also set SPACES_ACCESS_KEY_ID env variable.
# Set the variable value in *.tfvars file or use the -var="spaces_access_key_id=..." CLI option
variable "spaces_access_key_id" {
  description = "Access key ID used for Spaces API operations."
  type        = string
  sensitive   = true
}

# You can also set SPACES_SECRET_ACCESS_KEY env variable
# Set the variable value in *.tfvars file or use the -var="spaces_secret_access_key=..." CLI option
variable "spaces_secret_access_key" {
  description = "Secret access key used for Spaces API operations."
  type        = string
  sensitive   = true
}

# # You can also set TF_VAR_doppler_token env variable
# # Set the variable value in *.tfvars file or use the -var="do_token=..." CLI option
variable "doppler_token" {
  description = "Doppler API token with read and write permissions."
  type        = string
  sensitive   = true
}

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

variable "doppler_project" {
  description = "The name of the Doppler project."
  type        = string
}

variable "doppler_config" {
  description = "The name of the Doppler config."
  type        = string
}