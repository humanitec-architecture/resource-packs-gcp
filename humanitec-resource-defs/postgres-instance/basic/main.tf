resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}cloudsql-postgres-instance-basic"
  name        = "${var.prefix}cloudsql-postgres-instance-basic"
  type        = "postgres-instance"

  driver_account = var.driver_account
  driver_inputs = {
    values_string = jsonencode({
      source = {
        path = "modules/cloudsql-instance/basic"
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
        prefix  = var.prefix
        app_id  = "$${context.app.id}"
        env_id  = "$${context.env.id}"
        res_id  = "$${context.res.id}"

        database_version = var.database_version
        tier             = var.tier
        private_network  = var.private_network
        port             = 5432
      }
    })
  }
}
