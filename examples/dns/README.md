# Example: dns resource based on GCP Cloud DNS

This example configures a [dns](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#dns) Resource Definition using GCP Cloud DNS.

The created Resource Definition can be used in your Score file using:

```yaml
resources:
  ...
  dns:
    type: dns
```

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
| dns\_basic | ../../humanitec-resource-defs/dns/basic | n/a |

## Resources

| Name | Type |
|------|------|
| [humanitec_application.example](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/application) | resource |
| [humanitec_resource_definition_criteria.dns_basic](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| credentials | GCP credentials | `string` | n/a | yes |
| managed\_zone | The name of the zone in which this record set will reside. | `string` | n/a | yes |
| managed\_zone\_dns\_name | The DNS name of the managed zone. | `string` | n/a | yes |
| project | GCP project ID | `string` | n/a | yes |
| region | n/a | `string` | n/a | yes |
| name | Name of the example application | `string` | `"hum-rp-dns-example"` | no |
| prefix | Prefix of the created resources | `string` | `"hum-rp-dns-ex-"` | no |
| resource\_packs\_gcp\_rev | GCP Resource Pack git ref | `string` | `"refs/heads/main"` | no |
| resource\_packs\_gcp\_url | GCP Resource Pack git url | `string` | `"https://github.com/humanitec-architecture/resource-packs-gcp.git"` | no |
<!-- END_TF_DOCS -->
