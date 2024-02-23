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
| [google_dns_record_set.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | n/a | `string` | n/a | yes |
| credentials | GCP credentials | `string` | n/a | yes |
| env\_id | n/a | `string` | n/a | yes |
| managed\_zone | The name of the zone in which this record set will reside. | `string` | n/a | yes |
| managed\_zone\_dns\_name | The DNS name of the managed zone. | `string` | n/a | yes |
| project | n/a | `string` | n/a | yes |
| region | GCP region | `string` | n/a | yes |
| res\_id | n/a | `string` | n/a | yes |
| subdomain | The subdomain of the DNS name that the DNS record is for. | `string` | n/a | yes |
| ip\_address | The IPv4 address that the DNS name should resolve to. | `string` | `""` | no |
| ipv6\_address | The IPv6 address that the DNS name should resolve to. | `string` | `""` | no |
| name | A valid fully qualified domain name that the DNS name should resolve to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| host | The DNS name. |
<!-- END_TF_DOCS -->