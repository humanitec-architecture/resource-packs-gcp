# Example: gcp-pubsub resource based on Google Cloud Pub/Sub

## Configuration
This example configures a [gcp-pubsub-topic](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#gcp-pubsub-topic) and a [gcp-pubsub-subscription](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#gcp-pubsub-subscription) Resource Definition using Google Cloud Pub/Sub.

Those Resource Definitions can be used in your Score file using:

```yaml
# publishing workload
containers:
  app:
    ...
    variables:
      TOPIC_NAME: ${resources.topic.name}
resources:
  ...
  topic:
    metadata:
      annotations:
        score.humanitec.io/resId: shared.main-topic
    type: gcp-pubsub-topic
    class: basic-publisher
```

```yaml
# subscribing workload
containers:
  app:
    ...
    variables:
      SUBSCRIPTION_NAME: ${resources.subscription.name}
resources:
  ...
  subscription:
    type: gcp-pubsub-subscription
    class: basic-subscriber
    params:
      topic_name: ${resources['gcp-pubsub-topic.basic#shared.main-topic'].outputs.name}
```

## Infrastructure setup
The workload service account will be automatically assigned to the necessary roles with the selected policies.

```mermaid
graph TD;
  topic["GCP Pub/Sub topic"]
  sub["GCP Pub/Sub subscription"]
  topic_account["GCP Service account"]
  sub_account["GCP Service account"]
  subgraph GKE Cluster
    topic_pod[workload pod]
    topic_service[Service Account]
    sub_pod[workload pod]
    sub_service[Service Account]
  end
  topic_service --> topic_account -- bind role on --> topic
  topic_service --> topic_pod
  topic --> topic_pod
  sub_service --> sub_account -- bind role on --> sub
  sub_service --> sub_pod
  sub --> sub_pod
  sub --> topic

```

## Orchestrator setup
The Resource Graph is using [delegator resources](https://developer.humanitec.com/platform-orchestrator/examples/resource-graph-patterns/#delegator-resource) to expose shared resources with different access policies.

```mermaid
graph LR;
  workload_1 --> delegator_1["delegator_1, resource_type: gcp-pubsub-topic", class: basic-publisher] --> shared.gcp-pubsub-topic_1["shared.gcp-pubsub-topic_1, resource_type: gcp-pubsub-topic"]
  workload_2 --> delegator_2["delegator_2, resource_type: gcp-pubsub-subscriber, class: basic-consumer"] --> shared.gcp-pubsub-subscriber_1["shared.gcp-pubsub-subscriber_1, resource_type: gcp-pubsub-subscriber"]
  workload_2 --> shared.delegator_1["shared.delegator_1, resource_type: gcp-pubsub-subscriber, class: basic-consumer"]
  workload_3 --> shared.delegator_1 --> shared.gcp-pubsub-subscriber_2["shared.gcp-pubsub-subscriber_2, resource_type: gcp-pubsub-subscriber"]
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| humanitec | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| humanitec | ~> 1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| gcp\_service\_account\_workload | ../../humanitec-resource-defs/gcp-service-account/workload | n/a |
| gps\_basic\_subscriber | ../../humanitec-resource-defs/gcp-pubsub-subscription/delegator | n/a |
| gpt\_basic\_publisher | ../../humanitec-resource-defs/gcp-pubsub-topic/delegator | n/a |
| iam\_role\_binding\_gcp\_pubsub\_subscription\_subscriber | ../../humanitec-resource-defs/gcp-iam-policy-binding/basic | n/a |
| iam\_role\_binding\_gcp\_pubsub\_topic\_publisher | ../../humanitec-resource-defs/gcp-iam-policy-binding/basic | n/a |
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
