<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| humanitec | ~> 0 |

## Providers

| Name | Version |
|------|---------|
| humanitec | ~> 0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| redis | ../../../humanitec-resource-defs/redis/basic | n/a |

## Resources

| Name | Type |
|------|------|
| [humanitec_application.example](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/application) | resource |
| [humanitec_resource_definition_criteria.redis](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alternative\_location\_id | n/a | `string` | n/a | yes |
| auth\_enabled | n/a | `bool` | n/a | yes |
| authorized\_network | n/a | `string` | n/a | yes |
| credentials | n/a | `any` | n/a | yes |
| humanitec\_org\_id | Humanitec organization where resource definitions will be applied | `string` | n/a | yes |
| humanitec\_token | Humanitec API token | `string` | n/a | yes |
| location\_id | n/a | `string` | n/a | yes |
| memory\_size\_gb | n/a | `number` | n/a | yes |
| project | n/a | `string` | n/a | yes |
| region | n/a | `string` | n/a | yes |
| humanitec\_host | Humanitec API host url | `string` | `"https://api.humanitec.io"` | no |
| name | Name of the example application | `string` | `"hum-rp-redis-example"` | no |
| prefix | Prefix of the created resources | `string` | `"hum-rp-redis-ex-"` | no |
| resource\_packs\_gcp\_rev | n/a | `string` | `"ref/heads/main"` | no |
| resource\_packs\_gcp\_url | n/a | `string` | `"https://github.com/humanitec-architecture/resource-packs-gcp.git"` | no |
<!-- END_TF_DOCS -->