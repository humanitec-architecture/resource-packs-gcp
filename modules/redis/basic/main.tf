locals {
  # Name restrictions https://cloud.google.com/memorystore/docs/memcached/instance-node-properties, not memcached, but still 40 chars
  default_name = substr("${var.prefix}${var.app_id}-${var.env_id}-${replace(var.res_id, ".", "-")}", 0, 40)
}

resource "google_redis_instance" "cache" {
  name         = coalesce(var.name, local.default_name)
  display_name = coalesce(var.display_name, local.default_name)

  tier                    = "STANDARD_HA"
  location_id             = var.location_id
  alternative_location_id = var.alternative_location_id

  memory_size_gb     = var.memory_size_gb
  redis_version      = var.redis_version
  authorized_network = var.authorized_network
  reserved_ip_range  = var.reserved_ip_range
  auth_enabled       = var.auth_enabled

  dynamic "maintenance_policy" {
    for_each = var.weekly_maintenance_windows
    content {
      weekly_maintenance_window {
        day = maintenance_policy.value["day"]
        start_time {
          hours   = maintenance_policy.value["start_hours"]
          minutes = maintenance_policy.value["start_minutes"]
          seconds = maintenance_policy.value["start_seconds"]
          nanos   = maintenance_policy.value["start_nanos"]
        }
      }
    }
  }
}
