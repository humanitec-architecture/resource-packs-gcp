resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}memorystore-redis"
  name        = "${var.prefix}memorystore-redis"
  type        = "redis"

  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
        credentials = var.credentials
      }

    })

    values_string = jsonencode({
      source = {
        path = "modules/redis/basic"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
      }

      variables = {
        name                       = var.name
        project                    = var.project
        region                     = var.region
        prefix                     = var.prefix
        app_id                     = "$${context.app.id}"
        env_id                     = "$${context.env.id}"
        res_id                     = "$${context.res.id}"
        memory_size_gb             = var.memory_size_gb
        location_id                = var.location_id
        alternative_location_id    = var.alternative_location_id
        authorized_network         = var.authorized_network
        redis_version              = var.redis_version
        display_name               = var.display_name
        reserved_ip_range          = var.reserved_ip_range
        weekly_maintenance_windows = var.weekly_maintenance_windows
        auth_enabled               = var.auth_enabled
      }
    })
  }
}
