module "network" {
  source = "../../../modules/network"

  region = "tor1"
  domain = "devreltim.io"
  tag    = "collision"

  enable_ssh   = true
}

output "module" {
  value = module.network
}
