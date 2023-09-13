variable "do_token" {}
variable "spaces_access_key_id" {}
variable "spaces_secret_access_key" {}

module "bucket" {
  source = "../../../modules/bucket"

  do_token                 = var.do_token
  spaces_access_key_id     = var.spaces_access_key_id
  spaces_secret_access_key = var.spaces_secret_access_key

  region = "ams3"
}

output "bucket" {
  value = module.bucket
}

module "database" {
  source = "../../../modules/database"

  do_token = var.do_token

  region = "ams3"
}

output "database" {
  value     = module.database
  sensitive = true
}