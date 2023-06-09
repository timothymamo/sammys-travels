variable "spaces_key" {}
variable "spaces_secret" {}
variable "google_api" {}

module "compute" {
  source = "../../../modules/compute"

  no_instances  = 5
  region        = "tor1"
  region_bucket = "nyc3"
  domain        = "devreltim.io"
  tags          = ["collision"]

  spaces_key    = var.spaces_key
  spaces_secret = var.spaces_secret
  google_api    = var.google_api

  ssh_keys = [37714963]
}

output "compute" {
  value = module.compute
}
