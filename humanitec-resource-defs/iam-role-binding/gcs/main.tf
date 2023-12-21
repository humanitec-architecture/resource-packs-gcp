resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/template"
  id          = "${var.prefix}iam-role-biding-gcs-${var.name}"
  name        = "${var.prefix}iam-role-biding-gcs-${var.name}"

  # TODO Switch the GCP type once available
  type = "aws-policy"

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
