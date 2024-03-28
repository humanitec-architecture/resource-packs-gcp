<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.17 |
| random | ~> 3.5 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 5.17 |
| random | ~> 3.5 |

## Resources

| Name | Type |
|------|------|
| [google_sql_database.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | n/a | `string` | n/a | yes |
| database\_version | The MySQL, PostgreSQL or SQL Server version to use. | `string` | n/a | yes |
| env\_id | n/a | `string` | n/a | yes |
| port | The port for the database (needs to match the database type) | `number` | n/a | yes |
| prefix | Prefix for all resources | `string` | n/a | yes |
| private\_network | The VPC network from which the Cloud SQL instance is accessible for private IP. | `string` | n/a | yes |
| project | GCP project ID | `string` | n/a | yes |
| region | GCP region | `string` | n/a | yes |
| res\_id | n/a | `string` | n/a | yes |
| tier | The machine type to use. | `string` | n/a | yes |
| name | Resource name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| host | The IP address the instance is available on. |
| name | The name of the database that the workload should connect to. |
| password | The password for the user. |
| port | The port on the host that the instance is available on. |
| username | The user that the workload should use to connect to the database. |
<!-- END_TF_DOCS -->