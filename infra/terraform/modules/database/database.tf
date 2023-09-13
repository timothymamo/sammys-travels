resource "digitalocean_database_cluster" "this" {
  name       = "sammys-travels-postgres-cluster"
  engine     = "pg"
  version    = "14"
  size       = var.db_size
  region     = var.region
  node_count = 1
  tags       = local.tags
}

resource "digitalocean_database_firewall" "this" {
  cluster_id = digitalocean_database_cluster.this.id

  rule {
    type  = "tag"
    value = "sammys-travels"
  }
}
