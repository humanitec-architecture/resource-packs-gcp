resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}clouddns-basic"
  name        = "${var.prefix}clouddns-basic"
  type        = "dns"

  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
        credentials = var.credentials
      }
    })

    values_string = jsonencode({
      source = {
        path = "modules/dns/basic"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
      }

      variables = {
        project               = var.project
        region                = var.region
        app_id                = "$${context.app.id}"
        env_id                = "$${context.env.id}"
        res_id                = "$${context.res.id}"
        managed_zone          = var.managed_zone
        managed_zone_dns_name = var.managed_zone_dns_name
        subdomain             = "$${context.app.id}-$${context.env.id}"
      }
    })
  }
}
