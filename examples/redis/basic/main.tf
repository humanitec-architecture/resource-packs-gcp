resource "humanitec_application" "example" {
  id   = var.name
  name = var.name
}

module "redis" {
  source = "../../../humanitec-resource-defs/redis/basic"

  prefix                  = var.prefix
  resource_packs_gcp_rev  = var.resource_packs_gcp_rev
  resource_packs_gcp_url  = var.resource_packs_gcp_url
  project                 = var.project
  region                  = var.region
  credentials             = var.credentials
  memory_size_gb          = var.memory_size_gb
  location_id             = var.location_id
  alternative_location_id = var.alternative_location_id
  authorized_network      = var.authorized_network
  auth_enabled            = var.auth_enabled
}

resource "humanitec_resource_definition_criteria" "redis" {
  resource_definition_id = module.redis.id
  app_id                 = humanitec_application.example.id
}
