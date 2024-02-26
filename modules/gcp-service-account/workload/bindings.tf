locals {
  parsed_bindings = [for g in var.bindings : jsondecode(g)]
}

resource "google_pubsub_subscription_iam_member" "main" {
  for_each = {
    for g in local.parsed_bindings :
    join("/", [g["subscription"], g["role"]]) => g if g["type"] == "pubsub_subscription"
  }

  subscription = each.value["subscription"]
  role         = each.value["role"]
  member       = "serviceAccount:${google_service_account.main[0].email}"
}

resource "google_pubsub_topic_iam_member" "main" {
  for_each = {
    for g in local.parsed_bindings :
    join("/", [g["topic"], g["role"]]) => g if g["type"] == "pubsub_topic"
  }

  topic  = each.value["topic"]
  role   = each.value["role"]
  member = "serviceAccount:${google_service_account.main[0].email}"
}

resource "google_storage_bucket_iam_member" "main" {
  for_each = {
    for g in local.parsed_bindings :
    join("/", [g["bucket"], g["role"]]) => g if g["type"] == "storage_bucket"
  }

  bucket = each.value["bucket"]
  role   = each.value["role"]
  member = "serviceAccount:${google_service_account.main[0].email}"
}
