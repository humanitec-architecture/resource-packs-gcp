output "host" {
  description = "The IP address of the instance."
  value       = google_redis_instance.cache.host
}

output "port" {
  description = "The IP address of the instance."
  value       = google_redis_instance.cache.port
}

output "username" {
  # redis doesn't use usernames yet
  value = ""
}

output "password" {
  value     = google_redis_instance.cache.auth_string
  sensitive = true
}
