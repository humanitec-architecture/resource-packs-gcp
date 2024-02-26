resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/template"
  id          = "${var.prefix}gcp-iam-policy-binding-${var.name}"
  name        = "${var.prefix}gcp-iam-policy-binding-${var.name}"

  type = "gcp-iam-policy-binding"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        outputs = <<EOL
binding: |
  {{ dict
    "type" "${var.type}"
    "${var.scope_key}" "${var.scope_value}"
    "role" "${var.role}"
  | toJson }}
EOL
      }
    })
  }
}
