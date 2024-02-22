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

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = data.google_compute_network.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

  depends_on = [google_project_service.servicenetworking]
}

module "mysql" {
  source = "../../humanitec-resource-defs/mysql/basic"

  prefix                 = var.prefix
  resource_packs_gcp_rev = var.resource_packs_gcp_rev
  resource_packs_gcp_url = var.resource_packs_gcp_url
  project                = var.project
  region                 = var.region
  credentials            = var.credentials

  database_version = "MYSQL_8_0"
  tier             = "db-f1-micro"
  private_network  = data.google_compute_network.network.id

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "humanitec_resource_definition_criteria" "mysql" {
  resource_definition_id = module.mysql.id
  app_id                 = humanitec_application.example.id
  force_delete           = true
}
