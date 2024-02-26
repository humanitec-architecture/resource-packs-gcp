<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.17 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 5.17 |

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | n/a | `string` | n/a | yes |
| credentials | GCP credentials | `string` | n/a | yes |
| env\_id | n/a | `string` | n/a | yes |
| location | The location of the bucket | `string` | n/a | yes |
| prefix | Prefix for all resources | `string` | n/a | yes |
| project | GCP project ID | `string` | n/a | yes |
| res\_id | n/a | `string` | n/a | yes |
| force\_destroy | Whether to force destroy the bucket when deleting | `bool` | `false` | no |
| name | Resource name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | n/a |
<!-- END_TF_DOCS -->
