resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}iam-role-biding-gcp-pubsub-subscription-subscriber"
  name        = "${var.prefix}iam-role-biding-gcp-pubsub-subscription-subscriber"

  # TODO Switch the GCP type once available
  type = "aws-policy"

  provision = {
    "gcp-service-account.default" = {
      match_dependents = true
      is_dependent     = false
    }
  }

  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
        credentials = var.credentials
      }
    })

    values_string = jsonencode({
      source = {
        path = "modules/iam-role-binding/gcp-pubsub-subscription-subscriber"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
      }

      variables = {
        res_id = "$${context.res.id}"
        app_id = "$${context.app.id}"
        env_id = "$${context.env.id}"

        project = var.project

        service_account = "$${resources.workload>gcp-service-account.outputs.email}"
      }
    })
  }
}
