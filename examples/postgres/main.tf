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

# Postgres instance

locals {
  # Define the shared postgres-instance resource id and class
  postgres_instance_res_id = "main-postgres"
  postgres_instance_class  = "default"

  # Individual postgres resource class
  postgres_basic_class = "default"

  # Service account workload identity policy class
  postgres_service_account_workload_identity_policy_class = "postgres-service-account-workload-identity"
}


data "google_compute_network" "network" {
  name = var.private_network
}

resource "google_project_service" "servicenetworking" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.prefix}private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = data.google_compute_network.network.id
}

# In case of getting "Cannot modify allocated ranges in CreateConnection. Please use UpdateConnection.",
# temporarily set `reserved_peering_ranges = []` run apply, reset afterwards and apply again.
#
# This is required due to https://github.com/hashicorp/terraform-provider-google/issues/3294
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = data.google_compute_network.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

  depends_on = [google_project_service.servicenetworking]
}

module "postgres_instance" {
  source = "../../humanitec-resource-defs/postgres-instance/basic"

  prefix                 = var.prefix
  resource_packs_gcp_rev = var.resource_packs_gcp_rev
  resource_packs_gcp_url = var.resource_packs_gcp_url
  append_logs_to_error   = true
  driver_account         = humanitec_resource_account.humanitec_provisioner.id
  project                = var.project
  region                 = var.region

  database_version = "POSTGRES_15"
  tier             = "db-f1-micro"
  private_network  = data.google_compute_network.network.id

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "humanitec_resource_definition_criteria" "postgres_instance" {
  resource_definition_id = module.postgres_instance.id
  app_id                 = humanitec_application.example.id
  class                  = local.postgres_instance_class
  res_id                 = local.postgres_instance_res_id
  force_delete           = true
}

module "postgres" {
  source = "../../humanitec-resource-defs/postgres/workload-identity"

  prefix                 = var.prefix
  resource_packs_gcp_rev = var.resource_packs_gcp_rev
  resource_packs_gcp_url = var.resource_packs_gcp_url
  append_logs_to_error   = true
  driver_account         = humanitec_resource_account.humanitec_provisioner.id
  project                = var.project
  region                 = var.region

  instance_resource     = "postgres-instance.${local.postgres_instance_class}#${local.postgres_instance_res_id}"
  policy_resource_class = local.postgres_service_account_workload_identity_policy_class
}

resource "humanitec_resource_definition_criteria" "postgres" {
  resource_definition_id = module.postgres.id
  app_id                 = humanitec_application.example.id
  class                  = local.postgres_basic_class
  force_delete           = true
}

# IAM role binding to be able to assume to database service account with workload identity
module "iam_role_binding_service_account_workload_identity" {
  source = "../../humanitec-resource-defs/gcp-iam-policy-binding/basic"

  prefix = var.prefix
  name   = "gcp-iam-policy-binding-sa-workload-identity"

  type        = "service_account"
  scope_key   = "service_account_id"
  scope_value = "$${resources['postgres.${local.postgres_basic_class}'].outputs.service_account_id}"
  role        = "roles/iam.workloadIdentityUser"
}

resource "humanitec_resource_definition_criteria" "iam_role_binding_service_account_workload_identity" {
  resource_definition_id = module.iam_role_binding_service_account_workload_identity.id
  app_id                 = humanitec_application.example.id
  class                  = local.postgres_service_account_workload_identity_policy_class
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
  append_logs_to_error   = true
  driver_account         = humanitec_resource_account.humanitec_provisioner.id

  project = var.project
  prefix  = var.prefix

  name = "hrp-pg-$${context.res.id}"
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
