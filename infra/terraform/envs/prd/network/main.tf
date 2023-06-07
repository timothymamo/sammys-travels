module "network" {
  source = "../../../modules/network"

  region = "ams3"
  domain = "devreltim.io"
  tag    = "cloudexpo"

  enable_ssh   = true
}

output "module" {
  value = module.network
}
