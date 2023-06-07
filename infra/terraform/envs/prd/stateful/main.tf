module "stateful" {
  source = "../../../modules/stateful"

  region = "ams3"
}

output "module" {
  value     = module.stateful
  sensitive = true
}
