# See https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#postgres for expected outputs

output "host" {
  description = "The IP address the instance is available on."
  value       = google_sql_database_instance.main.private_ip_address
}

output "name" {
  description = "The name of the database that the workload should connect to."
  value       = google_sql_database.main.name
}

output "port" {
  description = "The port on the host that the instance is available on."
  value       = var.port
}

output "username" {
  description = "The user that the workload should use to connect to the database."
  value       = google_sql_user.main.name
}

output "password" {
  description = "The password for the user."
  value       = google_sql_user.main.password
  sensitive   = true
}
