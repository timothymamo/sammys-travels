resource "digitalocean_spaces_bucket" "this" {
  name   = local.bucket_name
  region = var.region_bucket != "" ? var.region_bucket : var.region
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "DELETE"]
    allowed_origins = ["https://sammys-travels.devreltim.io"]
    max_age_seconds = 3000
  }
}

resource "digitalocean_spaces_bucket_object" "bermudas" {
  region = local.region
  bucket = digitalocean_spaces_bucket.this.name
  key    = "bermudas.jpg"
  source = "${path.module}/images/bermudas.jpg"
  acl    = "public-read"
}

resource "digitalocean_spaces_bucket_object" "grindavik" {
  region = local.region
  bucket = digitalocean_spaces_bucket.this.name
  key    = "grindavik.jpg"
  source = "${path.module}/images/grindavik.jpg"
  acl    = "public-read"
}

resource "digitalocean_spaces_bucket_object" "tokyo" {
  region = local.region
  bucket = digitalocean_spaces_bucket.this.name
  key    = "tokyo.jpg"
  source = "${path.module}/images/tokyo.jpg"
  acl    = "public-read"
}
