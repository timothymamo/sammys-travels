output "port" {
  description = "Network port that the database cluster is listening on."
  value       = digitalocean_database_cluster.this.port
}

output "host" {
  description = "Database cluster's hostname."
  value       = digitalocean_database_cluster.this.host
}

output "user" {
  description = "Username for the cluster's default user."
  value       = digitalocean_database_cluster.this.user
}

output "password" {
  description = "Password for the cluster's default user."
  value       = digitalocean_database_cluster.this.password
}

output "database" {
  description = "Name of the cluster's default database."
  value       = digitalocean_database_cluster.this.database
}

output "bucket_name" {
  description = "Name of the Spaces Bucket."
  value       = digitalocean_spaces_bucket.this.bucket_domain_name
}
