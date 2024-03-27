# See https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#postgres-instance for expected outputs

output "host" {
  description = "The IP address the instance is available on."
  value       = google_sql_database_instance.main.private_ip_address
}

output "port" {
  description = "The port on the host that the instance is available on."
  value       = var.port
}

output "instance" {
  description = "The name of the instance that the workload should connect to."
  value       = google_sql_database_instance.main.name
}

output "connection_name" {
  description = "The connection name that the workload should use to connect to the database."
  value       = google_sql_database_instance.main.connection_name
}
