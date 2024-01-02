resource "google_storage_bucket" "main" {
  name          = var.prefix
  location      = var.location
  force_destroy = var.force_destroy

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
