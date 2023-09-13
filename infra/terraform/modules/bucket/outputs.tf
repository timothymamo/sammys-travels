output "bucket_name" {
  description = "Name of the Spaces Bucket."
  value       = digitalocean_spaces_bucket.this.bucket_domain_name
}
