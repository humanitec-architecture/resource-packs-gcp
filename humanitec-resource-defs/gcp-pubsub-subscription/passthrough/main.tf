resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/template"
  id          = "${var.prefix}gcp-pubsub-subscription-${var.gps_resource_class}-${var.policy_resource_class}"
  name        = "${var.prefix}gcp-pubsub-subscription-${var.gps_resource_class}-${var.policy_resource_class}"
  type        = "gcp-pubsub-subscription"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        outputs = <<EOL
name: "$${resources['gcp-pubsub-subscription.${var.gps_resource_class}'].outputs.name}"
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
