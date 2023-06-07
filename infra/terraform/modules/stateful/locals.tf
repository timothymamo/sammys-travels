resource "random_id" "id" {
  byte_length = 8
}

locals {
  bucket_name = "sammys-travels-${random_id.id.hex}"

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
