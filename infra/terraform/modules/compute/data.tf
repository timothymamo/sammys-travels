data "digitalocean_droplet_snapshot" "sammys_travels" {
  name_regex  = "^sammys-travels-20\\d{12}$"
  region      = var.region
  most_recent = true
}

data "cloudinit_config" "this" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    filename     = "cloud-config.yaml"
    content      = local.cloud_config
  }

  part {
    content_type = "text/x-shellscript"
    filename     = "init.sh"
    content      = <<-EOF
      #!/bin/bash
      cd /root/sammys_travels
      /usr/bin/docker compose -f /root/sammys_travels/docker-compose.yml up -d
    EOF
  }
}

data "digitalocean_database_cluster" "sammys_travels" {
  name = "sammys-travels-postgres-cluster"
}

data "digitalocean_spaces_buckets" "sammys_travels" {
  filter {
    key    = "region"
    values = [var.region_bucket] != [""] ? [var.region_bucket] : [var.region]
  }
  filter {
    key      = "name"
    values   = ["^sammys-travels-[a-z0-9]{16}$"]
    match_by = "re"
  }
  sort {
    key       = "name"
    direction = "desc"
  }
}


data "doppler_secrets" "sammys_travels" {
  project = var.doppler_project
  config  = var.doppler_config
}
