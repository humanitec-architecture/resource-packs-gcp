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

### Resources

| Name | Type |
|------|------|
| [google_sql_database_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |

### Inputs

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

### Outputs

| Name | Description |
|------|-------------|
| connection\_name | The connection name that the workload should use to connect to the database. |
| host | The IP address the instance is available on. |
| instance | The name of the instance that the workload should connect to. |
| port | The port on the host that the instance is available on. |
<!-- END_TF_DOCS -->