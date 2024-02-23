resource "humanitec_application" "example" {
  id   = var.name
  name = var.name
}

# GCP pubsub

locals {
  # Classes used to build the resource definition graph
  gpt_basic_class             = "basic"
  gps_basic_class             = "basic"
  gpt_publisher_policy_class  = "gcp-pubsub-subscription-basic-publisher"
  gps_subscriber_policy_class = "gcp-pubsub-subscription-basic-subscriber"

  # Classes that developers can select from
  gpt_basic_publisher_class  = "basic-publisher"
  gps_basic_subscriber_class = "basic-subscriber"
}

# Required resources for workload identity

module "k8s_service_account" {
  source = "../../humanitec-resource-defs/k8s/service-account"

  prefix = var.prefix
}

resource "humanitec_resource_definition_criteria" "k8s_service_account" {
  resource_definition_id = module.k8s_service_account.id
  app_id                 = humanitec_application.example.id
  force_delete           = true
}

module "gcp_service_account_workload" {
  source = "../../humanitec-resource-defs/gcp-service-account/workload"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  prefix      = var.prefix

  name = "hrp-ps-$${context.res.id}"
}

resource "humanitec_resource_definition_criteria" "gcp_service_account_workload" {
  resource_definition_id = module.gcp_service_account_workload.id
  app_id                 = humanitec_application.example.id
  force_delete           = true
}

module "workload" {
  source = "../../humanitec-resource-defs/workload/service-account"

  prefix = var.prefix
}

resource "humanitec_resource_definition_criteria" "workload" {
  resource_definition_id = module.workload.id
  app_id                 = humanitec_application.example.id
  force_delete           = true
}
