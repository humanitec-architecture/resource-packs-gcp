resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}iam-role-biding-gcs-admin"
  name        = "${var.prefix}iam-role-biding-gcs-admin"

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
        path = "modules/iam-role-binding/gcs-admin"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
      }

      variables = {
        res_id = "$${context.res.id}"
        app_id = "$${context.app.id}"
        env_id = "$${context.env.id}"

        project = var.project

        bucket          = "$${resources['gcs.${var.gcs_resource_definition_class}'].outputs.arn}"
        service_account = "$${resources['gcp-service-account.default'].outputs.email}"
      }
    })
  }
}
