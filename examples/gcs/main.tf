

locals {
  res_def_prefix = "${var.humanitec_application}-"
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

# cloud storage bucket

locals {
  gcs_class              = "default"
  gcs_admin_policy_class = "gcs-admin"
}

module "gcs_basic" {
  source = "../../humanitec-resource-defs/gcs/basic"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project       = var.project
  credentials   = var.credentials
  force_destroy = true
  location      = var.location
  prefix        = local.res_def_prefix
}

resource "humanitec_resource_definition_criteria" "gcs_basic" {
  resource_definition_id = module.gcs_basic.id
  app_id                 = humanitec_application.example.id
  class                  = local.gcs_class
}

module "iam_role_binding_gcs_admin" {
  source = "../../humanitec-resource-defs/iam-role-binding/gcs-admin"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  prefix      = local.res_def_prefix
}

resource "humanitec_resource_definition_criteria" "iam_role_binding_gcs_admin" {
  resource_definition_id = module.iam_role_binding_gcs_admin.id
  app_id                 = humanitec_application.example.id
  class                  = local.gcs_admin_policy_class
}

module "gcp_service_account_workload" {
  source = "../../humanitec-resource-defs/gcp-service-account/workload"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  credentials = var.credentials
  roles       = ["roles/storage.admin"]
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
