# gcp pubsub subscription related resources

module "pubsub_subscription_basic" {
  source = "../../humanitec-resource-defs/gcp-pubsub-subscription/basic"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  prefix      = local.res_def_prefix
}

resource "humanitec_resource_definition_criteria" "pubsub_subscription_basic" {
  resource_definition_id = module.pubsub_subscription_basic.id
  app_id                 = humanitec_application.example.id
  class                  = local.topic_class
}

module "iam_role_binding_gcp_pubsub_subscription_subscriber" {
  source = "../../humanitec-resource-defs/iam-role-binding/gcp-pubsub-subscription-subscriber"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  prefix      = local.res_def_prefix
}

resource "humanitec_resource_definition_criteria" "iam_role_binding_gcp_pubsub_subscription_subscriber" {
  resource_definition_id = module.iam_role_binding_gcp_pubsub_subscription_subscriber.id
  app_id                 = humanitec_application.example.id
  class                  = local.subscriber_binding_class
}
