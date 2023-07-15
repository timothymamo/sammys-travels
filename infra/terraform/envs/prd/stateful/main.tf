variable "do_token" {}
variable "spaces_access_key_id" {}
variable "spaces_secret_access_key" {}

module "stateful" {
  source = "../../../modules/stateful"

  do_token                 = var.do_token
  spaces_access_key_id     = var.spaces_access_key_id
  spaces_secret_access_key = var.spaces_secret_access_key

  region = "ams3"
}

output "module" {
  value     = module.stateful
  sensitive = true
}
