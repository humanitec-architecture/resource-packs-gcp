# gcp pubsub topic related resources

module "pubsub_topic_basic" {
  source = "../../humanitec-resource-defs/gcp-pubsub-topic/basic"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  prefix      = var.prefix
}

resource "humanitec_resource_definition_criteria" "pubsub_topic_basic" {
  resource_definition_id = module.pubsub_topic_basic.id
  app_id                 = humanitec_application.example.id
  class                  = local.gpt_basic_class
  force_delete           = true
}

# policy

module "iam_role_binding_gcp_pubsub_topic_publisher" {
  source = "../../humanitec-resource-defs/gcp-iam-policy-binding/gcp-pubsub-topic"

  prefix = var.prefix

  gcp_pubsub_topic_resource_class = "basic"
  name                            = "publisher"
  role                            = "roles/pubsub.publisher"
}

resource "humanitec_resource_definition_criteria" "iam_role_binding_gcp_pubsub_topic_publisher" {
  resource_definition_id = module.iam_role_binding_gcp_pubsub_topic_publisher.id
  app_id                 = humanitec_application.example.id
  class                  = local.gpt_publisher_policy_class
  force_delete           = true
}

## Exposed passthrough resource definition

module "gpt_basic_publisher" {
  source = "../../humanitec-resource-defs/gcp-pubsub-topic/passthrough"

  prefix = var.prefix

  gpt_resource_class    = local.gpt_basic_class
  policy_resource_class = local.gpt_publisher_policy_class
}

resource "humanitec_resource_definition_criteria" "gpt_basic_publisher" {
  resource_definition_id = module.gpt_basic_publisher.id
  app_id                 = humanitec_application.example.id
  class                  = local.gpt_basic_publisher_class
  force_delete           = true
}
