# Secrets Module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_doppler"></a> [doppler](#provider\_doppler) | 1.2.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_doppler_token"></a> [doppler\_token](#input\_doppler\_token) | Doppler API token with read and write permissions. | `string` | n/a | yes |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | The name of the Doppler environment. | `string` | n/a | yes |
| <a name="input_env_slug"></a> [env\_slug](#input\_env\_slug) | The slug of the Doppler environment. | `string` | n/a | yes |
| <a name="input_spaces_access_key_id"></a> [spaces\_access\_key\_id](#input\_spaces\_access\_key\_id) | DO Spaces Key. | `string` | n/a | yes |
| <a name="input_spaces_secret_access_key"></a> [spaces\_secret\_access\_key](#input\_spaces\_secret\_access\_key) | DO Spaces Secret. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->