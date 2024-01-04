locals {
  k8s_service_account_name = "${var.app_id}-${var.env_id}-${trimprefix(var.res_id, "modules.")}"
}

resource "random_string" "service_account_suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "google_service_account" "main" {
  display_name = "${var.prefix} workload service account ${var.app_id}/${var.env_id}/${var.res_id}"
  account_id   = "${var.prefix}-${random_string.service_account_suffix.result}"
}

resource "google_project_iam_member" "role" {
  for_each = var.roles

  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.main.email}"
}

resource "google_service_account_iam_member" "workload_identity_k8s_service_account" {
  service_account_id = google_service_account.main.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project}.svc.id.goog[${var.namespace}/${local.k8s_service_account_name}]"
}
