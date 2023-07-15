variable "do_token" {}

module "base" {
  source = "../../../modules/base"

  do_token = var.do_token

  domain = "devreltim.io"
}
