# Compute Module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.2.0 |
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.25.0 |
| <a name="provider_doppler"></a> [doppler](#provider\_doppler) | 1.2.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | DO API token with read and write permissions. | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain name where the Supabase instance is accessible. The final domain will be of the format `supabase.example.com` | `string` | n/a | yes |
| <a name="input_doppler_config"></a> [doppler\_config](#input\_doppler\_config) | The name of the Doppler config. | `string` | n/a | yes |
| <a name="input_doppler_project"></a> [doppler\_project](#input\_doppler\_project) | The name of the Doppler project. | `string` | n/a | yes |
| <a name="input_doppler_token"></a> [doppler\_token](#input\_doppler\_token) | Doppler API token with read and write permissions. | `string` | n/a | yes |
| <a name="input_no_instances"></a> [no\_instances](#input\_no\_instances) | The number of droplets to be deployed. | `number` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where the Droplet will be created. | `string` | n/a | yes |
| <a name="input_spaces_access_key_id"></a> [spaces\_access\_key\_id](#input\_spaces\_access\_key\_id) | Access key ID used for Spaces API operations. | `string` | n/a | yes |
| <a name="input_spaces_secret_access_key"></a> [spaces\_secret\_access\_key](#input\_spaces\_secret\_access\_key) | Secret access key used for Spaces API operations. | `string` | n/a | yes |
| <a name="input_droplet_backups"></a> [droplet\_backups](#input\_droplet\_backups) | Boolean controlling if backups are made. Defaults to true. | `bool` | `true` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | The unique slug that identifies the type of Droplet. | `string` | `"s-1vcpu-2gb"` | no |
| <a name="input_region_bucket"></a> [region\_bucket](#input\_region\_bucket) | The region where the Bucket is located. Defaults to Droplet region if empty. | `string` | `""` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | A list of SSH key IDs or fingerprints to enable in the format [12345, 123456]. Only one of `var.ssh_keys` or `var.ssh_pub_file` needs to be specified and should be used. | `list(string)` | `[]` | no |
| <a name="input_ssh_pub_file"></a> [ssh\_pub\_file](#input\_ssh\_pub\_file) | The path to the public key ssh file. Only one of var.ssh\_pub\_file or var.ssh\_keys needs to be specified and should be used. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of the tags to be added to the default (`["supabase", "digitalocean", "terraform"]`) Droplet tags. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4_address"></a> [ipv4\_address](#output\_ipv4\_address) | The IPv4 address assigned to the droplet. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->