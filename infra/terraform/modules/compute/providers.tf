terraform {
  required_version = "~> 1.3.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.25.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.2.0"
    }
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.2.2"
    }
  }
}

provider "digitalocean" {
  token             = var.do_token
  spaces_access_id  = var.spaces_access_key_id
  spaces_secret_key = var.spaces_secret_access_key
}

provider "doppler" {
  doppler_token = var.doppler_token
}