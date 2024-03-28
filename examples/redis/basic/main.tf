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

module "redis" {
  source = "../../../humanitec-resource-defs/redis/basic"

  prefix                  = var.prefix
  resource_packs_gcp_rev  = var.resource_packs_gcp_rev
  resource_packs_gcp_url  = var.resource_packs_gcp_url
  append_logs_to_error    = true
  driver_account          = humanitec_resource_account.humanitec_provisioner.id
  project                 = var.project
  region                  = var.region
  memory_size_gb          = var.memory_size_gb
  location_id             = var.location_id
  alternative_location_id = var.alternative_location_id
  authorized_network      = var.authorized_network
  auth_enabled            = var.auth_enabled
}

resource "humanitec_resource_definition_criteria" "redis" {
  resource_definition_id = module.redis.id
  app_id                 = humanitec_application.example.id
  force_delete           = true
}
