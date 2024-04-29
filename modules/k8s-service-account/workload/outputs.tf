output "name" {
  value = local.k8s_service_account_name
}

output "manifests" {
  description = "The Kubernetes manifests that should be applied to the cluster to create the k8s service-account."
  value       = local.manifests
}
