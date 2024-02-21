# Example: postgres resource based on GCP CloudSQL

This example configures a [postgres](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#postgres) Resource Definition using GCP CloudSQL.

The created Resource Definition can be used in your Score file using:

```yaml
resources:
  ...
  db:
    type: postgres
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.17 |
| humanitec | ~> 0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 5.17 |
| humanitec | ~> 0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| postgres | ../../humanitec-resource-defs/postgres/basic | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_project_service.servicenetworking](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [humanitec_application.example](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/application) | resource |
| [humanitec_resource_definition_criteria.postgres](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| credentials | n/a | `string` | n/a | yes |
| private\_network | The VPC network from which the Cloud SQL instance is accessible for private IP. | `string` | n/a | yes |
| project | n/a | `string` | n/a | yes |
| region | n/a | `string` | n/a | yes |
| name | Name of the example application | `string` | `"hum-rp-postgres-example"` | no |
| prefix | Prefix of the created resources | `string` | `"hum-rp-postgres-ex-"` | no |
| resource\_packs\_gcp\_rev | n/a | `string` | `"ref/heads/main"` | no |
| resource\_packs\_gcp\_url | n/a | `string` | `"https://github.com/humanitec-architecture/resource-packs-gcp.git"` | no |
<!-- END_TF_DOCS -->