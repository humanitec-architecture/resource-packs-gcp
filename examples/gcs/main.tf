resource "humanitec_application" "example" {
  id   = var.name
  name = var.name
}

# GCS bucket

locals {
  # Classes used to build the resource definition graph
  gcs_basic_class            = "basic"
  gcs_admin_policy_class     = "gcs-basic-admin"
  gcs_read_only_policy_class = "gcs-basic-read-only"

  # Classes that developers can select from
  gcs_basic_admin_class     = "basic-admin"
  gcs_basic_read_only_class = "basic-read-only"
}


module "gcs_basic" {
  source = "../../humanitec-resource-defs/gcs/basic"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project       = var.project
  credentials   = var.credentials
  force_destroy = true
  location      = var.location

  prefix = var.prefix
}

resource "humanitec_resource_definition_criteria" "gcs_basic" {
  resource_definition_id = module.gcs_basic.id
  app_id                 = humanitec_application.example.id
  class                  = local.gcs_basic_class
  force_delete           = true
}

# Add different access policy to gcs basic bucket

# Admin

## Policy

module "iam_role_binding_gcs_admin" {
  source = "../../humanitec-resource-defs/gcp-iam-policy-binding/basic"

  prefix = var.prefix
  name   = "gcp-iam-policy-binding-gcs-basic-admin"

  type        = "storage_bucket"
  scope_key   = "bucket"
  scope_value = "$${resources['gcs.${local.gcs_basic_class}'].outputs.name}"
  role        = "roles/storage.admin"
}

resource "humanitec_resource_definition_criteria" "iam_role_binding_gcs_admin" {
  resource_definition_id = module.iam_role_binding_gcs_admin.id
  app_id                 = humanitec_application.example.id
  class                  = local.gcs_admin_policy_class
  force_delete           = true
}

## Exposed passthrough resource definition
module "gcs_basic_admin" {
  source = "../../humanitec-resource-defs/gcs/passthrough"

  prefix = var.prefix

  gcs_resource_class    = local.gcs_basic_class
  policy_resource_class = local.gcs_admin_policy_class
}

resource "humanitec_resource_definition_criteria" "gcs_basic_admin" {
  resource_definition_id = module.gcs_basic_admin.id
  app_id                 = humanitec_application.example.id
  class                  = local.gcs_basic_admin_class
  force_delete           = true
}

# Read-only

## Policy

module "iam_role_binding_gcs_read_only" {
  source = "../../humanitec-resource-defs/gcp-iam-policy-binding/basic"

  prefix = var.prefix
  name   = "gcs-basic-read-only"

  type        = "storage_bucket"
  scope_key   = "bucket"
  scope_value = "$${resources['gcs.${local.gcs_basic_class}'].outputs.name}"
  role        = "roles/storage.objectViewer"
}

resource "humanitec_resource_definition_criteria" "iam_role_binding_gcs_read_only" {
  resource_definition_id = module.iam_role_binding_gcs_read_only.id
  app_id                 = humanitec_application.example.id
  class                  = local.gcs_read_only_policy_class
  force_delete           = true
}

## Exposed passthrough resource definition
module "gcs_basic_read_only" {
  source = "../../humanitec-resource-defs/gcs/passthrough"

  prefix = var.prefix

  gcs_resource_class    = local.gcs_basic_class
  policy_resource_class = local.gcs_read_only_policy_class
}

resource "humanitec_resource_definition_criteria" "gcs_basic_read_only" {
  resource_definition_id = module.gcs_basic_read_only.id
  app_id                 = humanitec_application.example.id
  class                  = local.gcs_basic_read_only_class
  force_delete           = true
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
