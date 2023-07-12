# # You can also set DIGITALOCEAN_TOKEN env variable
# # Set the variable value in *.tfvars file or use the -var="do_token=..." CLI option
# variable "do_token" {
#   description = "DO API token with read and write permissions."
#   type        = string
#   sensitive   = true
# }

# # You can also set SPACES_ACCESS_KEY_ID env variable.
# # Set the variable value in *.tfvars file or use the -var="spaces_access_key_id=..." CLI option
# variable "spaces_access_key_id" {
#   description = "Access key ID used for Spaces API operations."
#   type        = string
#   sensitive   = true
# }

# # You can also set SPACES_SECRET_ACCESS_KEY env variable
# # Set the variable value in *.tfvars file or use the -var="spaces_secret_access_key=..." CLI option
# variable "spaces_secret_access_key" {
#   description = "Secret access key used for Spaces API operations."
#   type        = string
#   sensitive   = true

variable "region" {
  description = "The region where the Database will be created."
  type        = string
}

variable "region_bucket" {
  description = "The region where the Bucket will be created. Defaults to Database region if empty."
  type        = string
  default     = ""
}

variable "db_size" {
  description = "The unique slug that identifies the type of Database."
  type        = string
  default     = "db-s-1vcpu-1gb"
}

variable "tags" {
  description = "A list of the tags to be added to the default (`[\"supabase\", \"digitalocean\", \"terraform\"]`) Droplet tags."
  type        = list(string)
  default     = []
}
