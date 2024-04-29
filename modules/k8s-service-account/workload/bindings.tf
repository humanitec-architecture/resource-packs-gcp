data "google_project" "project" {
  project_id = var.project
}

locals {
  parsed_bindings = [for g in var.bindings : jsondecode(g)]

  principal = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${var.project}.svc.id.goog/subject/ns/${var.namespace}/sa/${local.k8s_service_account_name}"
}

resource "google_project_iam_member" "role" {
  for_each = var.roles

  project = var.project
  role    = each.key
  member  = local.principal
}

resource "google_pubsub_subscription_iam_member" "main" {
  for_each = {
    for g in local.parsed_bindings :
    join("/", [g["subscription"], g["role"]]) => g if g["type"] == "pubsub_subscription"
  }

  subscription = each.value["subscription"]
  role         = each.value["role"]
  member       = local.principal
}

resource "google_pubsub_topic_iam_member" "main" {
  for_each = {
    for g in local.parsed_bindings :
    join("/", [g["topic"], g["role"]]) => g if g["type"] == "pubsub_topic"
  }

  topic  = each.value["topic"]
  role   = each.value["role"]
  member = local.principal
}

resource "google_service_account_iam_member" "main" {
  for_each = {
    for g in local.parsed_bindings :
    join("/", [g["service_account_id"], g["role"]]) => g if g["type"] == "service_account"
  }

  service_account_id = each.value["service_account_id"]
  role               = each.value["role"]
  member             = local.principal
}

resource "google_storage_bucket_iam_member" "main" {
  for_each = {
    for g in local.parsed_bindings :
    join("/", [g["bucket"], g["role"]]) => g if g["type"] == "storage_bucket"
  }

  bucket = each.value["bucket"]
  role   = each.value["role"]
  member = local.principal
}
