# Example: gcp-pubsub resource based on Google Cloud Pub/Sub

This example configures a [gcp-pubsub-topic](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#gcp-pubsub-topic) and a [gcp-pubsub-subscription](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#gcp-pubsub-subscription) Resource Definition using Google Cloud Pub/Sub.

Those Resource Definitions can be used in your Score file using:

```yaml
resources:
  ...
  topic:
    type: gcp-pubsub-topic
    class: basic-publisher
```

```yaml
resources:
  ...
  subscription:
    type: gcp-pubsub-subscription
    class: basic-subscriber
```

The workload service account will automatically be assigned the necessary GCP Service Account with the selected role bindings.

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
| gcp\_service\_account\_workload | ../../humanitec-resource-defs/gcp-service-account/workload | n/a |
| gps\_basic\_subscriber | ../../humanitec-resource-defs/gcp-pubsub-subscription/passthrough | n/a |
| gpt\_basic\_publisher | ../../humanitec-resource-defs/gcp-pubsub-topic/passthrough | n/a |
| iam\_role\_binding\_gcp\_pubsub\_subscription\_subscriber | ../../humanitec-resource-defs/gcp-iam-policy-binding/gcp-pubsub-subscription | n/a |
| iam\_role\_binding\_gcp\_pubsub\_topic\_publisher | ../../humanitec-resource-defs/gcp-iam-policy-binding/gcp-pubsub-topic | n/a |
| k8s\_service\_account | ../../humanitec-resource-defs/k8s/service-account | n/a |
| pubsub\_subscription\_basic | ../../humanitec-resource-defs/gcp-pubsub-subscription/basic | n/a |
| pubsub\_topic\_basic | ../../humanitec-resource-defs/gcp-pubsub-topic/basic | n/a |
| workload | ../../humanitec-resource-defs/workload/service-account | n/a |

## Resources

| Name | Type |
|------|------|
| [humanitec_application.example](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/application) | resource |
| [humanitec_resource_definition_criteria.gcp_service_account_workload](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.gps_basic_subscriber](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.gpt_basic_publisher](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.iam_role_binding_gcp_pubsub_subscription_subscriber](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.iam_role_binding_gcp_pubsub_topic_publisher](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.k8s_service_account](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.pubsub_subscription_basic](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.pubsub_topic_basic](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.workload](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| credentials | GCP credentials | `string` | n/a | yes |
| project | GCP project ID | `string` | n/a | yes |
| name | Name of the example application | `string` | `"hum-rp-gcp-pubsub-example"` | no |
| prefix | n/a | `string` | `"hum-rp-gcp-pubsub-ex-"` | no |
| resource\_packs\_gcp\_rev | GCP Resource Pack git ref | `string` | `"refs/heads/main"` | no |
| resource\_packs\_gcp\_url | GCP Resource Pack git url | `string` | `"https://github.com/humanitec-architecture/resource-packs-gcp.git"` | no |
<!-- END_TF_DOCS -->
