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

  ssh_fingerprints = var.ssh_keys != [""] ? var.ssh_keys : [digitalocean_ssh_key.this[0].fingerprint]

  db_info = data.digitalocean_database_cluster.sammys_travels

  bucket_info = data.digitalocean_spaces_buckets.sammys_travels

  env_file = templatefile("${path.module}/files/.env.tftpl",
    {
      TF_POSTGRES_PORT       = "${local.db_info.port}",
      TF_POSTGRES_HOST       = "${local.db_info.private_host}",
      TF_POSTGRES_USERNAME   = "${local.db_info.user}",
      TF_POSTGRES_PASSWORD   = "${local.db_info.password}",
      TF_POSTGRES_DB         = "${local.db_info.database}",
      TF_POSTGRES_SCHEMA     = "public",
    }
  )

  be_env_file = templatefile("${path.module}/files/.env-backend.tftpl",
    {
      TF_SPACES_BUCKET       = "${local.bucket_info.buckets[0].name}",
      TF_SPACES_KEY          = data.doppler_secrets.sammys_travels.map.SPACES_ACCESS_KEY_ID,
      TF_SPACES_SECRET       = data.doppler_secrets.sammys_travels.map.SPACES_SECRET_ACCESS_KEY,
      TF_SPACES_ENDPOINT_URL = "https://${local.bucket_info.buckets[0].region}.digitaloceanspaces.com",
      TF_GOOGLE_API_KEY      = data.doppler_secrets.sammys_travels.map.GOOGLE_API_KEY,
    }
  )

  fe_env_file = templatefile("${path.module}/files/.env-frontend.tftpl",
    {
      TF_SITE_API = "https://sammys-travels.${var.domain}/api/",
      TF_BUCKET   = "${local.bucket_info.buckets[0].bucket_domain_name}",
    }
  )

  cloud_config = <<-END
    #cloud-config
    ${jsonencode({
  write_files = [
    {
      path        = "/root/sammys_travels/.env"
      permissions = "0644"
      owner       = "root:root"
      encoding    = "b64"
      content     = base64encode("${local.env_file}")
    },
    {
      path        = "/root/sammys_travels/.env-backend"
      permissions = "0644"
      owner       = "root:root"
      encoding    = "b64"
      content     = base64encode("${local.be_env_file}")
    },
    {
      path        = "/root/sammys_travels/.env-frontend"
      permissions = "0644"
      owner       = "root:root"
      encoding    = "b64"
      content     = base64encode("${local.fe_env_file}")
    },
  ]
})}
  END
}
