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
| [google_project_iam_member.role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.workload_identity_k8s_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_member.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | n/a | `string` | n/a | yes |
| bindings | List of additional bindings to grant to the service account | `set(string)` | n/a | yes |
| credentials | GCP credentials | `string` | n/a | yes |
| env\_id | n/a | `string` | n/a | yes |
| namespace | k8s namespace | `string` | n/a | yes |
| prefix | n/a | `string` | n/a | yes |
| project | GCP project ID | `string` | n/a | yes |
| res\_id | n/a | `string` | n/a | yes |
| roles | List of project-level roles to grant to the service account | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| email | n/a |
| k8s\_service\_account\_name | n/a |
<!-- END_TF_DOCS -->