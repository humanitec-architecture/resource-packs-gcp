output "host" {
  description = "The DNS name."
  value       = google_dns_record_set.main.name
}
