module "stateful" {
  source = "../../../modules/stateful"

  region        = "tor1"
  region_bucket = "nyc3"
}

output "module" {
  value     = module.stateful
  sensitive = true
}
