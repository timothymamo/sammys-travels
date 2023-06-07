resource "digitalocean_loadbalancer" "public" {
  name        = "sammys-travels-lb"
  region      = var.region
  droplet_tag = "sammys-travels"

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 80
    target_protocol = "http"

    certificate_name = data.digitalocean_certificate.cert.name
  }

  forwarding_rule {
    entry_port     = 22
    entry_protocol = "tcp"

    target_port     = 22
    target_protocol = "tcp"
  }

  healthcheck {
    port                   = 80
    path                   = "/api/health"
    protocol               = "http"
    check_interval_seconds = 3
    unhealthy_threshold    = 2
    healthy_threshold      = 2
  }
}

resource "digitalocean_record" "a_record" {
  domain = var.domain
  type   = "A"
  name   = "sammys-travels"
  value  = digitalocean_loadbalancer.public.ip
}

resource "digitalocean_firewall" "this" {
  name = "sammys-travels"

  tags = local.tags

  dynamic "inbound_rule" {
    for_each = local.inbound_rule == null ? [] : local.inbound_rule

    content {
      protocol                  = inbound_rule.value.protocol
      port_range                = inbound_rule.value.port_range
      source_addresses          = inbound_rule.value.source_addresses
      source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
    }
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
