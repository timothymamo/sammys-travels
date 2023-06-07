module "network" {
  source = "../../../modules/network"

  region = "ams3"
  domain = "devreltim.io"
  tag    = "cloudexpo"

  enable_ssh   = true
  ssh_ip_range = ["77.251.75.155"]
}

output "module" {
  value = module.network
}
