variable "do_token" {}

module "certificate" {
  source = "../../../modules/certificate"

  do_token = var.do_token

  domain = "devreltim.io"
}

output "certificate" {
  value = module.certificate
}