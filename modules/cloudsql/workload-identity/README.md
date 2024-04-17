<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.17 |
| random | ~> 3.5 |

### Providers

| Name | Version |
|------|---------|
| google | ~> 5.17 |
| random | ~> 3.5 |

### Resources

| Name | Type |
|------|------|
| [google_project_iam_member.role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_sql_database.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_user.iam_service_account_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_integer.proxy_port](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_string.service_account_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | n/a | `string` | n/a | yes |
| env\_id | n/a | `string` | n/a | yes |
| instance | The name of the Cloud SQL instance. | `string` | n/a | yes |
| instance\_connection\_name | The connection name of the Cloud SQL instance. | `string` | n/a | yes |
| port | The port for the database (needs to match the database type) | `number` | n/a | yes |
| project | GCP project ID | `string` | n/a | yes |
| region | GCP region | `string` | n/a | yes |
| res\_id | n/a | `string` | n/a | yes |
| name | Resource name | `string` | `""` | no |

### Outputs

| Name | Description |
|------|-------------|
| host | The IP address the instance is available on. |
| manifests | The Kubernetes manifests that should be applied to the cluster to connect to the database. |
| name | The name of the database that the workload should connect to. |
| password | The password for the user. |
| port | The port on the host that the instance is available on. |
| service\_account\_id | Name of the service account that the workload should use to connect to the database. |
| username | The user that the workload should use to connect to the database. |
<!-- END_TF_DOCS -->