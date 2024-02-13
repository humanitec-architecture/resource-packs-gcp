resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}gcp-service-account-workload"
  name        = "${var.prefix}gcp-service-account-workload"
  type        = "gcp-service-account"

  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
        credentials = var.credentials
      }
    })

    values_string = jsonencode({
      source = {
        path = "modules/gcp-service-account/workload"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
      }

      variables = {
        project = var.project
        roles   = var.roles

        prefix = var.prefix

        namespace = "$${resources.k8s-namespace#k8s-namespace.outputs.namespace}"

        bindings = "$${resources.workload>aws-policy.outputs.binding}"

        res_id = "$${context.res.id}"
        app_id = "$${context.app.id}"
        env_id = "$${context.env.id}"
      }
    })
  }
}
