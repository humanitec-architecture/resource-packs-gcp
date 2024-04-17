<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| humanitec | ~> 1.0 |

### Providers

| Name | Version |
|------|---------|
| humanitec | ~> 1.0 |

### Resources

| Name | Type |
|------|------|
| [humanitec_resource_definition.main](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Resource definition name | `string` | n/a | yes |
| prefix | n/a | `string` | n/a | yes |
| role | The role to bind to the scope, e.g. roles/storage.admin or roles/pubsub.publisher | `string` | n/a | yes |
| scope\_key | Type the scope is applied to, e.g. bucket or topic | `string` | n/a | yes |
| scope\_value | The name of the resource the scope is applied to, e.g. my-bucket or my-topic | `string` | n/a | yes |
| type | The type of binding that should be created, e.g. storage\_bucket or pubsub\_topic | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| id | n/a |
<!-- END_TF_DOCS -->