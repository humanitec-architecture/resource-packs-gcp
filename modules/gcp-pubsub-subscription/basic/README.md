<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.1 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 5.1 |

## Resources

| Name | Type |
|------|------|
| [google_pubsub_subscription.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | n/a | `string` | n/a | yes |
| env\_id | n/a | `string` | n/a | yes |
| prefix | n/a | `string` | n/a | yes |
| project | GCP project ID | `string` | n/a | yes |
| res\_id | n/a | `string` | n/a | yes |
| topic\_name | Name of the topic resource | `string` | n/a | yes |
| name | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| name | n/a |
<!-- END_TF_DOCS -->