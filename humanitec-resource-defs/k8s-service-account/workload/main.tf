resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}k8s-service-account-workload"
  name        = "${var.prefix}k8s-service-account-workload"
  type        = "k8s-service-account"

  driver_account = var.driver_account
  driver_inputs = {
    values_string = jsonencode({
      source = {
        path = "modules/k8s-service-account/workload"
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
        project = var.project
        roles   = var.roles

        name = var.name

        namespace = "$${resources.k8s-namespace#k8s-namespace.outputs.namespace}"

        bindings = "$${resources.workload>gcp-iam-policy-binding.outputs.binding}"

        res_id = "$${context.res.id}"
        app_id = "$${context.app.id}"
        env_id = "$${context.env.id}"
      }

      manifests_output = "manifests"
    })
  }
}
