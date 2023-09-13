locals {
  default_tags = [
    "sammys-travels",
    "digitalocean",
    "terraform"
  ]

  tags = concat(
    local.default_tags,
    var.tags
  )
}
