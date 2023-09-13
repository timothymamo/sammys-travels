variable "do_token" {}
variable "spaces_access_key_id" {}
variable "spaces_secret_access_key" {}
variable "doppler_token" {}

module "compute" {
  source = "../../../modules/compute"

  do_token                 = var.do_token
  spaces_access_key_id     = var.spaces_access_key_id
  spaces_secret_access_key = var.spaces_secret_access_key
  doppler_token            = var.doppler_token

  no_instances = 10
  region       = "ams3"
  domain       = "devreltim.io"
  tags         = ["doppler"]

  doppler_project = "backend"
  doppler_config  = "prd"

  ssh_keys = [37714963]
}

output "module" {
  value = module.compute
}
