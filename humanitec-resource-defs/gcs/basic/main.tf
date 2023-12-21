resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}gcs-basic"
  name        = "${var.prefix}gcs-basic"
  type        = "gcs"

  # provision = {
  #   for s in var.policy_classes : "aws-policy.${s}" => {
  #     match_dependents = true
  #     is_dependent     = false
  #   }
  # }

  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
        credentials = var.credentials
      }
    })

    values_string = jsonencode({
      source = {
        path = "modules/gcs/basic"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
      }

      variables = {
        # TODO: How to template the bucket name?
        # prefix = "${var.prefix}$${context.res.id}"
        prefix = "${var.prefix}basic-bucket"

        res_id = "$${context.res.id}"
        app_id = "$${context.app.id}"
        env_id = "$${context.env.id}"

        project       = var.project
        force_destroy = var.force_destroy
        location      = var.location
      }
    })
  }
}
