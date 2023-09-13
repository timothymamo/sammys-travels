# Stateful Module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.25.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | DO API token with read and write permissions. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where the Database will be created. | `string` | n/a | yes |
| <a name="input_db_size"></a> [db\_size](#input\_db\_size) | The unique slug that identifies the type of Database. | `string` | `"db-s-1vcpu-1gb"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of the tags to be added to the default (`["supabase", "digitalocean", "terraform"]`) Database tags. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database"></a> [database](#output\_database) | Name of the cluster's default database. |
| <a name="output_host"></a> [host](#output\_host) | Database cluster's hostname. |
| <a name="output_password"></a> [password](#output\_password) | Password for the cluster's default user. |
| <a name="output_port"></a> [port](#output\_port) | Network port that the database cluster is listening on. |
| <a name="output_user"></a> [user](#output\_user) | Username for the cluster's default user. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->