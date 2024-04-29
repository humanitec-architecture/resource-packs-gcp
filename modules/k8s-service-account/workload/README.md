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
| [google_project_iam_member.role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_pubsub_subscription_iam_member.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_member) | resource |
| [google_pubsub_topic_iam_member.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_member) | resource |
| [google_service_account_iam_member.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_member.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | n/a | `string` | n/a | yes |
| bindings | List of additional bindings to grant to the service account | `set(string)` | n/a | yes |
| env\_id | n/a | `string` | n/a | yes |
| namespace | k8s namespace | `string` | n/a | yes |
| project | GCP project ID | `string` | n/a | yes |
| res\_id | n/a | `string` | n/a | yes |
| roles | List of project-level roles to grant to the service account | `set(string)` | n/a | yes |
| name | Resource name | `string` | `""` | no |

### Outputs

| Name | Description |
|------|-------------|
| manifests | The Kubernetes manifests that should be applied to the cluster to create the k8s service-account. |
| name | n/a |
<!-- END_TF_DOCS -->
