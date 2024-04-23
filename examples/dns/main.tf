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

# cloud dns

module "dns_basic" {
  source = "../../humanitec-resource-defs/dns/basic"

  prefix = var.prefix

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev
  append_logs_to_error   = true
  driver_account         = humanitec_resource_account.humanitec_provisioner.id

  project = var.project
  region  = var.region

  managed_zone = var.managed_zone
}

resource "humanitec_resource_definition_criteria" "dns_basic" {
  resource_definition_id = module.dns_basic.id
  app_id                 = humanitec_application.example.id
  force_delete           = true
}
