locals {
  account_required = length(var.bindings) + length(var.roles) > 0

  default_name = "${var.prefix}${var.app_id}-${var.env_id}-${var.res_id}"

  name           = coalesce(var.name, local.default_name)
  sanitized_name = replace(local.name, ".", "-")

  # Name restrictions https://kubernetes.io/docs/concepts/overview/working-with-objects/names/
  k8s_service_account_name = trimsuffix(substr(local.sanitized_name, 0, 64), "-")
}

resource "google_service_account" "main" {
  count = local.account_required ? 1 : 0

  display_name = local.name
  # Name restrictions https://cloud.google.com/iam/quotas, 30 chars
  account_id = trimsuffix(substr(local.sanitized_name, 0, 30), "-")
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
