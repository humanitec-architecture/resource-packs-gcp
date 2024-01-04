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
| [google_pubsub_subscription_iam_member.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | n/a | `string` | n/a | yes |
| credentials | GCP credentials | `string` | n/a | yes |
| env\_id | n/a | `string` | n/a | yes |
| project | GCP project ID | `string` | n/a | yes |
| service\_account | n/a | `string` | n/a | yes |
| subscription | The subscription name to bind to attach IAM policy to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
<!-- END_TF_DOCS -->