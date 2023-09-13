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

variable "region" {
  description = "The region where the Bucket will be created."
  type        = string
  default     = ""
}
