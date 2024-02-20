resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/template"
  id          = "${var.prefix}gcp-iam-policy-binding-gcs-${var.name}"
  name        = "${var.prefix}gcp-iam-policy-binding-gcs-${var.name}"

  type = "gcp-iam-policy-binding"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        outputs = <<EOL
binding: |
  {{ dict
    "type" "storage_bucket"
    "bucket" "$${resources['gcs.${var.gcs_resource_class}'].outputs.name}"
    "role" "${var.role}"
  | toJson }}
EOL
      }
    })
  }
}
