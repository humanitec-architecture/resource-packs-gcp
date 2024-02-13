locals {
  k8s_service_account_name = "${var.app_id}-${var.env_id}-${trimprefix(var.res_id, "modules.")}"
  account_required         = length(var.bindings) + length(var.roles) > 0
}

resource "google_service_account" "main" {
  count = local.account_required ? 1 : 0

  display_name = "${var.prefix}workload service account"
  account_id   = "${var.prefix}workload"
}

resource "google_project_iam_member" "role" {
  for_each = var.roles

  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.main[0].email}"
}

resource "google_service_account_iam_member" "workload_identity_k8s_service_account" {
  count = local.account_required ? 1 : 0

  service_account_id = google_service_account.main[0].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project}.svc.id.goog[${var.namespace}/${local.k8s_service_account_name}]"
}
