locals {
  # Name restrictions https://cloud.google.com/storage/docs/buckets#naming
  default_name = substr("${var.prefix}${var.app_id}-${var.env_id}-${replace(var.res_id, ".", "-")}", 0, 63)
}

resource "google_storage_bucket" "main" {
  name          = coalesce(var.name, local.default_name)
  location      = var.location
  force_destroy = var.force_destroy

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
