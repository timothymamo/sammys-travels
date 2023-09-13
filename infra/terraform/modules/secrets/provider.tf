terraform {
  required_version = "~> 1.3.0"

  required_providers {
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.2.2"
    }
  }
}

provider "doppler" {
  doppler_token = var.doppler_token
}