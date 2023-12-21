locals {
  k8s_service_account_name = "${var.app_id}-${var.env_id}-${trimprefix(var.res_id, "modules.")}"
}

resource "google_service_account" "main" {
  display_name = var.prefix
  account_id   = var.prefix
}

resource "google_project_iam_member" "role" {
  for_each = var.roles

  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.main.email}"
}

resource "google_service_account_iam_member" "workload_identity_k8s_service_account" {
  service_account_id = google_service_account.default.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project}.svc.id.goog[${var.namespace}/${local.k8s_service_account_name}]"
}
