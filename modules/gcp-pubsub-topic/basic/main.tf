locals {
  # Name restrictions none?
  default_name = substr("${var.prefix}${var.app_id}-${var.env_id}-${replace(var.res_id, ".", "-")}", 0, 255)
}

resource "google_pubsub_topic" "main" {
  name = coalesce(var.name, local.default_name)
}
