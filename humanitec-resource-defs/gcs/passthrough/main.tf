resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/template"
  id          = "${var.prefix}gcs-${var.gcs_resource_class}-${var.policy_resource_class}"
  name        = "${var.prefix}gcs-${var.gcs_resource_class}-${var.policy_resource_class}"
  type        = "gcs"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        outputs = <<EOL
name: "$${resources['gcs.${var.gcs_resource_class}'].outputs.name}"
EOL
      }
    })
  }

  provision = {
    "gcp-iam-policy-binding.${var.policy_resource_class}" = {
      match_dependents = true
      is_dependent     = false
    }
  }
}
