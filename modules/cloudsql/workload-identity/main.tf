locals {
  # https://www.postgresql.org/docs/current/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS
  default_name = trimsuffix(lower(substr(replace(var.res_id, ".", "-"), 0, 63)), "-")
}

resource "google_sql_database" "main" {
  instance = var.instance

  name = coalesce(var.name, local.default_name)
}

resource "random_string" "service_account_suffix" {
  length  = 16
  special = false
  upper   = false
}

resource "google_service_account" "main" {
  display_name = "SQL user for Humanitec ${var.app_id}/${var.env_id}/${var.res_id}"
  # Name restrictions https://cloud.google.com/iam/quotas, 30 chars
  # as this easily conflicts with everything, we use random values here :-/
  account_id = "hum-sql-${random_string.service_account_suffix.result}"
}

resource "google_project_iam_member" "role" {
  for_each = toset([
    # role required for the cloud-sql-proxy to generate certificates
    "roles/cloudsql.client",
    # role required for the cloud-sql-proxy for iam authentication
    "roles/cloudsql.instanceUser"
  ])

  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.main.email}"
}

locals {
  # Note: for Postgres only, GCP requires omitting the ".gserviceaccount.com" suffix
  # from the service account email due to length limits on database usernames.
  username = var.port == 5432 ? trimsuffix(google_service_account.main.email, ".gserviceaccount.com") : google_service_account.main.email
}

resource "google_sql_user" "iam_service_account_user" {
  instance = var.instance

  name = local.username
  type = "CLOUD_IAM_SERVICE_ACCOUNT"
}

# Generate a random port for the cloud-sql-proxy as there might be multiple proxies in one pod
resource "random_integer" "proxy_port" {
  min = 49152
  max = 65535
}

locals {
  # From https://github.com/GoogleCloudPlatform/cloud-sql-proxy/tree/main/examples/k8s-sidecar#run-the-cloud-sql-proxy-as-a-sidecar
  sidecar_container = {
    name  = "cloud-sql-proxy"
    image = "gcr.io/cloud-sql-connectors/cloud-sql-proxy:2.10.1"
    args = [
      "--private-ip",
      "--port",
      tostring(random_integer.proxy_port.result),
      "--impersonate-service-account",
      google_service_account.main.email, # The workload identity service account will impersonate the db service account to connect to the database
      "--auto-iam-authn",
      var.instance_connection_name,
    ]
    security_context = {
      run_as_non_root = true
    }
  }
  manifests = [
    {
      location = "containers"
      data     = local.sidecar_container
    }
  ]
}
