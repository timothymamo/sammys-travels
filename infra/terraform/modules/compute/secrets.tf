resource "doppler_secret" "spaces_secret" {
  project = var.doppler_project
  config = var.doppler_config
  name = "POSTGRES_PASSWORD"
  value = local.db_info.password
}