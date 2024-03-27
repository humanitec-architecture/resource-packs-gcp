resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}cloudsql-postgres-workload-identity"
  name        = "${var.prefix}cloudsql-postgres-workload-identity"
  type        = "postgres"

  driver_account = var.driver_account
  driver_inputs = {
    values_string = jsonencode({
      source = {
        path = "modules/cloudsql/workload-identity"
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
        name    = var.name
        project = var.project
        region  = var.region
        app_id  = "$${context.app.id}"
        env_id  = "$${context.env.id}"
        res_id  = "$${context.res.id}"

        host                     = "$${resources['${var.instance_resource}'].outputs.host}"
        instance                 = "$${resources['${var.instance_resource}'].outputs.instance}"
        instance_connection_name = "$${resources['${var.instance_resource}'].outputs.connection_name}"
        port                     = "$${resources['${var.instance_resource}'].outputs.port}"
      }

      manifests_output = "manifests"
    })
  }

  provision = {
    "gcp-iam-policy-binding.${var.policy_resource_class}" = {
      match_dependents = true
      is_dependent     = false
    }
  }
}
