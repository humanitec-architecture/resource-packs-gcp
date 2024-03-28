# See https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#postgres for expected outputs

output "host" {
  description = "The IP address the instance is available on."
  value       = "localhost" # workloads should connect to the Cloud SQL instance via the Cloud SQL Proxy
}

output "name" {
  description = "The name of the database that the workload should connect to."
  value       = google_sql_database.main.name
}

output "port" {
  description = "The port on the host that the instance is available on."
  value       = random_integer.proxy_port.result
}

output "username" {
  description = "The user that the workload should use to connect to the database."
  value       = local.username
}

output "password" {
  description = "The password for the user."
  value       = ""
  sensitive   = true
}

output "manifests" {
  description = "The Kubernetes manifests that should be applied to the cluster to connect to the database."
  value       = local.manifests
}

output "service_account_id" {
  description = "Name of the service account that the workload should use to connect to the database."
  value       = google_service_account.main.name
}
