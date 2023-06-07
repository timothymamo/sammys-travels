resource "digitalocean_droplet" "this" {
  count = var.no_instances

  image      = data.digitalocean_droplet_snapshot.sammys_travels.id
  name       = "sammys-travels-droplet-${count.index}"
  region     = var.region
  size       = var.droplet_size
  monitoring = true
  backups    = var.droplet_backups
  ssh_keys   = local.ssh_fingerprints
  user_data  = data.cloudinit_config.this.rendered
  tags       = local.tags

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "digitalocean_ssh_key" "this" {
  count = var.ssh_pub_file == "" ? 0 : 1

  name       = "Sammys Travels Droplet SSH Key"
  public_key = file(var.ssh_pub_file)
}
