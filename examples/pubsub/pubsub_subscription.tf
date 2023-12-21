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
}

# policy

module "iam_role_binding_gcp_pubsub_subscription_subscriber" {
  source = "../../humanitec-resource-defs/iam-role-binding/gcp-pubsub-subscription"

  prefix = var.prefix

  gcp_pubsub_subscription_resource_class = "basic"
  name                                   = "subscriber"
  role                                   = "roles/pubsub.subscriber"
}

resource "humanitec_resource_definition_criteria" "iam_role_binding_gcp_pubsub_subscription_subscriber" {
  resource_definition_id = module.iam_role_binding_gcp_pubsub_subscription_subscriber.id
  app_id                 = humanitec_application.example.id
  class                  = local.gps_subscriber_policy_class
}

## Exposed passthrough resource definition

module "gps_basic_subscriber" {
  source = "../../humanitec-resource-defs/gcp-pubsub-subscription/passthrough"

  prefix = var.prefix

  gps_resource_class    = local.gps_basic_class
  policy_resource_class = local.gps_subscriber_policy_class
}

resource "humanitec_resource_definition_criteria" "gps_basic_subscriber" {
  resource_definition_id = module.gps_basic_subscriber.id
  app_id                 = humanitec_application.example.id
  class                  = local.gps_basic_subscriber_class
}
