locals {
  parsed_bindings = [for g in var.bindings : jsondecode(g)]
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
