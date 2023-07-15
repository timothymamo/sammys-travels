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

variable "google_api" {
  description = "Google Geolocation API key."
  type        = string
  sensitive   = true
}
