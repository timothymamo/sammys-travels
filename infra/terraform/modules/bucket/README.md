# Stateful Module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.25.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | DO API token with read and write permissions. | `string` | n/a | yes |
| <a name="input_spaces_access_key_id"></a> [spaces\_access\_key\_id](#input\_spaces\_access\_key\_id) | Access key ID used for Spaces API operations. | `string` | n/a | yes |
| <a name="input_spaces_secret_access_key"></a> [spaces\_secret\_access\_key](#input\_spaces\_secret\_access\_key) | Secret access key used for Spaces API operations. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where the Bucket will be created. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | Name of the Spaces Bucket. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->