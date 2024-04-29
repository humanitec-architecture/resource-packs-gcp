# GCP service account used by Humanitec to provision resources

resource "google_service_account" "humanitec_provisioner" {
  account_id  = var.name
  description = "Account used by Humanitec to provision resources"
}

resource "google_project_iam_member" "humanitec_provisioner" {
  project = var.project
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.humanitec_provisioner.email}"
}

resource "google_service_account_key" "humanitec_provisioner" {
  service_account_id = google_service_account.humanitec_provisioner.name
}

resource "humanitec_resource_account" "humanitec_provisioner" {
  id   = var.name
  name = var.name
  type = "gcp"

  credentials = base64decode(google_service_account_key.humanitec_provisioner.private_key)

  depends_on = [
    # Otherwise the account looses permissions before the resources are deleted
    google_project_iam_member.humanitec_provisioner
  ]
}

# Example application and resource definition criteria

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
  append_logs_to_error   = true
  driver_account         = humanitec_resource_account.humanitec_provisioner.id

  project       = var.project
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

## Exposed delegator resource definition
module "gcs_basic_admin" {
  source = "../../humanitec-resource-defs/gcs/delegator"

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

## Exposed delegator resource definition
module "gcs_basic_read_only" {
  source = "../../humanitec-resource-defs/gcs/delegator"

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

module "k8s_service_account_workload" {
  source = "../../humanitec-resource-defs/k8s-service-account/workload"

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev
  append_logs_to_error   = true
  driver_account         = humanitec_resource_account.humanitec_provisioner.id

  project = var.project
  prefix  = var.prefix
}

resource "humanitec_resource_definition_criteria" "k8s_service_account_workload" {
  resource_definition_id = module.k8s_service_account_workload.id
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
