locals {
  res_def_prefix = "${var.app_name}-"
}

resource "humanitec_application" "example" {
  id   = var.app_name
  name = var.app_name
}

# cloud dns

module "dns_basic" {
  source = "../../humanitec-resource-defs/dns/basic"

  prefix = local.res_def_prefix

  resource_packs_gcp_url = var.resource_packs_gcp_url
  resource_packs_gcp_rev = var.resource_packs_gcp_rev

  project     = var.project
  region      = var.region
  credentials = var.credentials

  managed_zone          = var.managed_zone
  managed_zone_dns_name = var.managed_zone_dns_name
}

resource "humanitec_resource_definition_criteria" "dns_basic" {
  resource_definition_id = module.dns_basic.id
  app_id                 = humanitec_application.example.id
}
