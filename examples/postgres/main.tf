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

# There is a bug
# walkaround `gcloud services vpc-peerings update --network=htc-ref-arch-vpc --ranges=hum-rp-mysql-ex-private-ip-address --service=servicenetworking.googleapis.com --force`
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = data.google_compute_network.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

  depends_on = [google_project_service.servicenetworking]
}

module "postgres" {
  source = "../../humanitec-resource-defs/postgres/basic"

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

resource "humanitec_resource_definition_criteria" "postgres" {
  resource_definition_id = module.postgres.id
  app_id                 = humanitec_application.example.id
  force_delete           = true
}
