output "email" {
  value = google_service_account.main.email
}

output "k8s_service_account_name" {
  value = local.k8s_service_account_name
}
