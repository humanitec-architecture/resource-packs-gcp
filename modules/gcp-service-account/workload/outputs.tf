output "email" {
  value = local.account_required ? google_service_account.main[0].email : ""
}

output "k8s_service_account_name" {
  value = local.k8s_service_account_name
}
