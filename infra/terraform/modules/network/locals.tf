resource "digitalocean_tag" "this" {
  name = var.tag
}

data "digitalocean_certificate" "cert" {
  name = "sammys-travels-le-cert"
}

locals {
  default_tags = [
    "sammys-travels",
    "digitalocean",
    "terraform"
  ]

  tags = concat(
    local.default_tags,
    [digitalocean_tag.this.id]
  )

  inbound_rule_ssh = var.enable_ssh ? [{
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.ssh_ip_range
  }] : []

  inbound_rule = concat(
    local.inbound_rule_ssh
  )
}
