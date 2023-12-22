resource "google_storage_bucket_iam_member" "main" {
  bucket = var.bucket
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account}"
}
