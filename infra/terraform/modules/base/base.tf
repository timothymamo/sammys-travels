data "digitalocean_domain" "this" {
  name = var.domain
}

resource "digitalocean_certificate" "cert" {
  name    = "sammys-travels-le-cert"
  type    = "lets_encrypt"
  domains = ["sammys-travels.${var.domain}"]
}
