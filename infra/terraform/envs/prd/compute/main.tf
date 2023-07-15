variable "do_token" {}
variable "doppler_token" {}

module "compute" {
  source = "../../../modules/compute"

  do_token      = var.do_token
  doppler_token = var.doppler_token

  no_instances  = 5
  region        = "ams3"
  domain        = "devreltim.io"
  tags          = ["doppler"]

  doppler_project = "backend"
  doppler_config  = "prd"

  ssh_keys = [37714963]
}

output "compute" {
  value = module.compute
}
