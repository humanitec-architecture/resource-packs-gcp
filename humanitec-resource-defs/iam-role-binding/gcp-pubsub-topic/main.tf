resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/template"
  id          = "${var.prefix}iam-role-biding-gcp-pubsub-topic-${var.name}"
  name        = "${var.prefix}iam-role-biding-gcp-pubsub-topic-${var.name}"

  # TODO Switch the GCP type once available
  type = "aws-policy"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        outputs = <<EOL
binding: |
  {{ dict
    "type" "pubsub_topic"
    "topic" "$${resources['gcp-pubsub-topic.${var.gcp_pubsub_topic_resource_class}'].outputs.name}"
    "role" "${var.role}"
  | toJson }}
EOL
      }
    })
  }
}
