variable "do_token" {}

module "network" {
  source = "../../../modules/network"

  do_token = var.do_token

  region = "ams3"
  domain = "devreltim.io"
  tag    = "doppler"

  enable_ssh   = true
}

output "module" {
  value = module.network
}
