resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}gcp-pubsub-topic-basic"
  name        = "${var.prefix}gcp-pubsub-topic-basic"
  type        = "gcp-pubsub-topic"

  driver_account = var.driver_account
  driver_inputs = {
    values_string = jsonencode({
      source = {
        path = "modules/gcp-pubsub-topic/basic"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
      }

      append_logs_to_error = var.append_logs_to_error

      credentials_config = {
        environment = {
          GOOGLE_CREDENTIALS = "*"
        }
      }

      variables = {
        prefix = var.prefix
        name   = var.name

        res_id = "$${context.res.id}"
        app_id = "$${context.app.id}"
        env_id = "$${context.env.id}"

        project = var.project
      }
    })
  }
}
