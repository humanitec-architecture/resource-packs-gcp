resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}gcp-pubsub-subscription-basic"
  name        = "${var.prefix}gcp-pubsub-subscription-basic"
  # TODO: Fix onces there is a real type
  type = "spanner-instance"

  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
        credentials = var.credentials
      }
    })

    values_string = jsonencode({
      source = {
        path = "modules/gcp-pubsub-subscription/basic"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
      }

      variables = {
        # TODO: How to template the bucket name?
        # prefix = "${var.prefix}$${context.res.id}"
        prefix = "${var.prefix}basic-subscription"

        res_id = "$${context.res.id}"
        app_id = "$${context.app.id}"
        env_id = "$${context.env.id}"

        project = var.project
      }
    })
  }
}
