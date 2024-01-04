resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}iam-role-biding-gcp-pubsub-topic-publisher"
  name        = "${var.prefix}iam-role-biding-gcp-pubsub-topic-publisher"

  # TODO Switch the GCP type once available
  type = "aws-policy"



  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
        credentials = var.credentials
      }
    })

    values_string = jsonencode({
      source = {
        path = "modules/iam-role-binding/gcp-pubsub-topic-publisher"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
      }

      variables = {
        res_id = "$${context.res.id}"
        app_id = "$${context.app.id}"
        env_id = "$${context.env.id}"

        project = var.project

        service_account = "$${resources['gcp-service-account.default#modules.app-publisher'].outputs.email}"
        # service_account = "invalid@humanitec.com"
        topic = "$${resources['spanner.${var.topic_class}'].outputs.name}"
      }
    })
  }
}
