resource "doppler_project" "backend" {
  name = "backend"
  description = "The main backend project"
}

resource "doppler_environment" "env" {
  project = doppler_project.backend.name
  slug = var.env_slug
  name = var.env_name
}

resource "doppler_secret" "spaces_secret" {
  project = doppler_project.backend.name
  config = doppler_environment.env.slug
  name = "SPACES_ACCESS_KEY_ID"
  value = var.spaces_access_key_id
}

resource "doppler_secret" "spaces_key" {
  project = doppler_project.backend.name
  config = doppler_environment.env.slug
  name = "SPACES_SECRET_ACCESS_KEY"
  value = var.spaces_secret_access_key
}

resource "doppler_secret" "google_api" {
  project = doppler_project.backend.name
  config = doppler_environment.env.slug
  name = "GOOGLE_API_KEY"
  value = var.google_api
}
