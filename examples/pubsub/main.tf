

locals {
  res_def_prefix           = "${var.humanitec_application}-"
  topic_class              = "default"
  publisher_binding_class  = "gcp-pubsub-topic-publisher"
  subscriber_binding_class = "gcp-pubsub-subscription-subscriber"
}

resource "humanitec_application" "example" {
  id   = var.humanitec_application
  name = var.humanitec_application
}

module "k8s_service_account" {
  source = "../../humanitec-resource-defs/k8s/service-account"

  prefix = local.res_def_prefix
}

resource "humanitec_resource_definition_criteria" "k8s_service_account" {
  resource_definition_id = module.k8s_service_account.id
  app_id                 = humanitec_application.example.id
}

module "gcp_service_account_workload" {
  source = "../../humanitec-resource-defs/gcp-service-account/workload"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  prefix      = local.res_def_prefix
}

resource "humanitec_resource_definition_criteria" "gcp_service_account_workload" {
  resource_definition_id = module.gcp_service_account_workload.id
  app_id                 = humanitec_application.example.id
}

module "workload" {
  source = "../../humanitec-resource-defs/workload/service-account"

  prefix = local.res_def_prefix
}

resource "humanitec_resource_definition_criteria" "workload" {
  resource_definition_id = module.workload.id
  app_id                 = humanitec_application.example.id
}
