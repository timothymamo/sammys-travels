# # You can also set DIGITALOCEAN_TOKEN env variable
# # Set the variable value in *.tfvars file or use the -var="do_token=..." CLI option
variable "do_token" {
  description = "DO API token with read and write permissions."
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "Domain name where the Supabase instance is accessible. The final domain will be of the format `supabase.example.com`"
  type        = string
}
