resource "humanitec_resource_definition" "main" {
  driver_type = "humanitec/terraform"
  id          = "${var.prefix}cloudsql-postgres"
  name        = "${var.prefix}cloudsql-postgres"
  type        = "postgres"

  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
        credentials = var.credentials
      }

    })

    values_string = jsonencode({
      source = {
        path = "modules/cloudsql/basic"
        rev  = var.resource_packs_gcp_rev
        url  = var.resource_packs_gcp_url
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
