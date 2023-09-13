# # You can also set DIGITALOCEAN_TOKEN env variable
# # Set the variable value in *.tfvars file or use the -var="do_token=..." CLI option
variable "do_token" {
  description = "DO API token with read and write permissions."
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The region where the Database will be created."
  type        = string
}

variable "db_size" {
  description = "The unique slug that identifies the type of Database."
  type        = string
  default     = "db-s-1vcpu-1gb"
}

variable "tags" {
  description = "A list of the tags to be added to the default (`[\"supabase\", \"digitalocean\", \"terraform\"]`) Database tags."
  type        = list(string)
  default     = []
}
