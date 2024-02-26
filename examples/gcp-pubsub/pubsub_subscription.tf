# gcp pubsub subscription related resources

module "pubsub_subscription_basic" {
  source = "../../humanitec-resource-defs/gcp-pubsub-subscription/basic"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  prefix      = var.prefix
}

resource "humanitec_resource_definition_criteria" "pubsub_subscription_basic" {
  resource_definition_id = module.pubsub_subscription_basic.id
  app_id                 = humanitec_application.example.id
  class                  = local.gps_basic_class
  force_delete           = true
}

# policy

module "iam_role_binding_gcp_pubsub_subscription_subscriber" {
  source = "../../humanitec-resource-defs/gcp-iam-policy-binding/basic"

  prefix = var.prefix
  name   = "gcp-pubsub-subscription-basic-subscriber"

  type        = "pubsub_subscription"
  scope_key   = "subscription"
  scope_value = "$${resources['gcp-pubsub-subscription.${local.gps_basic_class}'].outputs.name}"
  role        = "roles/pubsub.subscriber"
}

resource "humanitec_resource_definition_criteria" "iam_role_binding_gcp_pubsub_subscription_subscriber" {
  resource_definition_id = module.iam_role_binding_gcp_pubsub_subscription_subscriber.id
  app_id                 = humanitec_application.example.id
  class                  = local.gps_subscriber_policy_class
  force_delete           = true
}

## Exposed delegator resource definition

module "gps_basic_subscriber" {
  source = "../../humanitec-resource-defs/gcp-pubsub-subscription/delegator"

  prefix = var.prefix

  gps_resource_class    = local.gps_basic_class
  policy_resource_class = local.gps_subscriber_policy_class
}

resource "humanitec_resource_definition_criteria" "gps_basic_subscriber" {
  resource_definition_id = module.gps_basic_subscriber.id
  app_id                 = humanitec_application.example.id
  class                  = local.gps_basic_subscriber_class
  force_delete           = true
}
