# # You can also set TF_VAR_doppler_token env variable
# # Set the variable value in *.tfvars file or use the -var="do_token=..." CLI option
variable "doppler_token" {
  description = "Doppler API token with read and write permissions."
  type        = string
  sensitive   = true
}

variable "spaces_access_key_id" {
  description = "DO Spaces Key."
  type        = string
  sensitive   = true
}

variable "spaces_secret_access_key" {
  description = "DO Spaces Secret."
  type        = string
  sensitive   = true
}

variable "env_slug" {
  description = "The slug of the Doppler environment."
  type        = string
}

variable "env_name" {
  description = "The name of the Doppler environment."
  type        = string
}