<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.17 |

### Providers

| Name | Version |
|------|---------|
| google | ~> 5.17 |

### Resources

| Name | Type |
|------|------|
| [google_redis_instance.cache](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alternative\_location\_id | n/a | `string` | n/a | yes |
| app\_id | n/a | `string` | n/a | yes |
| authorized\_network | n/a | `string` | n/a | yes |
| env\_id | n/a | `string` | n/a | yes |
| location\_id | n/a | `string` | n/a | yes |
| memory\_size\_gb | n/a | `number` | n/a | yes |
| prefix | Prefix for all resources | `string` | n/a | yes |
| project | GCP project | `string` | n/a | yes |
| region | GCP region | `string` | n/a | yes |
| res\_id | n/a | `string` | n/a | yes |
| auth\_enabled | n/a | `bool` | `false` | no |
| display\_name | Resource display name | `string` | `""` | no |
| name | Resource name | `string` | `""` | no |
| redis\_version | n/a | `string` | `"REDIS_4_0"` | no |
| reserved\_ip\_range | n/a | `string` | `null` | no |
| weekly\_maintenance\_windows | n/a | `any` | `{}` | no |

### Outputs

| Name | Description |
|------|-------------|
| host | The IP address of the instance. |
| password | n/a |
| port | The IP address of the instance. |
| username | n/a |
<!-- END_TF_DOCS -->