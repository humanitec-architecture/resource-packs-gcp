<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| humanitec | ~> 1.0 |

### Providers

| Name | Version |
|------|---------|
| humanitec | ~> 1.0 |

### Resources

| Name | Type |
|------|------|
| [humanitec_resource_definition.main](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alternative\_location\_id | n/a | `string` | n/a | yes |
| authorized\_network | n/a | `string` | n/a | yes |
| driver\_account | The ID of the Resource Account which should be used. | `string` | n/a | yes |
| location\_id | n/a | `string` | n/a | yes |
| memory\_size\_gb | n/a | `number` | n/a | yes |
| prefix | Prefix for all resources | `string` | n/a | yes |
| project | n/a | `string` | n/a | yes |
| region | GCP region | `string` | n/a | yes |
| append\_logs\_to\_error | Append Terraform logs to error messages. | `bool` | `false` | no |
| auth\_enabled | n/a | `bool` | `false` | no |
| display\_name | Resource name (can contain placeholders like ${context.app.id}) | `string` | `""` | no |
| name | Resource name (can contain placeholders like ${context.app.id}) | `string` | `""` | no |
| redis\_version | n/a | `string` | `"REDIS_4_0"` | no |
| reserved\_ip\_range | n/a | `string` | `null` | no |
| resource\_packs\_gcp\_rev | n/a | `string` | `"ref/heads/main"` | no |
| resource\_packs\_gcp\_url | n/a | `string` | `"https://github.com/humanitec-architecture/resource-packs-gcp.git"` | no |
| weekly\_maintenance\_windows | n/a | `any` | `{}` | no |

### Outputs

| Name | Description |
|------|-------------|
| id | n/a |
<!-- END_TF_DOCS -->