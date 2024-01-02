# gcp pubsub publishing related resources

module "pubsub_topic_basic" {
  source = "../../humanitec-resource-defs/gcp-pubsub-topic/basic"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  prefix      = local.res_def_prefix
}

resource "humanitec_resource_definition_criteria" "pubsub_topic_basic" {
  resource_definition_id = module.pubsub_topic_basic.id
  app_id                 = humanitec_application.example.id
  class                  = local.topic_class
}

module "iam_role_binding_gcp_pubsub_topic_publisher" {
  source = "../../humanitec-resource-defs/iam-role-binding/gcp-pubsub-topic-publisher"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  prefix      = local.res_def_prefix
}

resource "humanitec_resource_definition_criteria" "iam_role_binding_gcp_pubsub_topic_publisher" {
  resource_definition_id = module.iam_role_binding_gcp_pubsub_topic_publisher.id
  app_id                 = humanitec_application.example.id
  class                  = local.publisher_binding_class
}
