locals {
  account_required = length(var.bindings) + length(var.roles) > 0

  # Name restrictions https://cloud.google.com/iam/quotas, 30 chars
  default_name = trimsuffix(substr("${var.prefix}${var.app_id}-${var.env_id}-${replace(var.res_id, ".", "-")}", 0, 30), "-")

  # Name restrictions https://kubernetes.io/docs/concepts/overview/working-with-objects/names/
  k8s_service_account_name = coalesce(var.name, local.default_name)
}

resource "google_service_account" "main" {
  count = local.account_required ? 1 : 0

  display_name = coalesce(var.name, local.default_name)
  account_id   = coalesce(var.name, local.default_name)
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
