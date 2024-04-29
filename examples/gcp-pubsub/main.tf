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
