variable "doppler_token" {}
variable "spaces_access_key_id" {}
variable "spaces_secret_access_key" {}

module "secrets" {
  source = "../../../modules/secrets"

  env_slug = "prd"
  env_name = "Production"

  doppler_token            = var.doppler_token
  spaces_access_key_id     = var.spaces_access_key_id
  spaces_secret_access_key = var.spaces_secret_access_key
}

output "module" {
  value = module.secrets
}
