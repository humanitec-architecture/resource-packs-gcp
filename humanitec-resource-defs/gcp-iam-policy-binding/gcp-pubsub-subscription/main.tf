resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/template"
  id          = "${var.prefix}gcp-iam-policy-binding-gcp-pubsub-subscription-${var.name}"
  name        = "${var.prefix}gcp-iam-policy-binding-gcp-pubsub-subscription-${var.name}"

  type = "gcp-iam-policy-binding"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        outputs = <<EOL
binding: |
  {{ dict
    "type" "pubsub_subscription"
    "subscription" "$${resources['gcp-pubsub-subscription.${var.gcp_pubsub_subscription_resource_class}'].outputs.name}"
    "role" "${var.role}"
  | toJson }}
EOL
      }
    })
  }
}
