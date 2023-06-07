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
  }
}

# provider "digitalocean" {
#   token = var.do_token
# }
