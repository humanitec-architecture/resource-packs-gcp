locals {
  # Service Accounts are already scoped by env/app through the k8s-namespace
  default_name = var.res_id

  name           = coalesce(var.name, local.default_name)
  sanitized_name = replace(local.name, ".", "-")

  # Name restrictions https://kubernetes.io/docs/concepts/overview/working-with-objects/names/
  k8s_service_account_name = trimsuffix(substr(local.sanitized_name, 0, 64), "-")
}

locals {
  service_account_manifest = {
    apiVersion : "v1",
    kind : "ServiceAccount",
    metadata : {
      name : local.k8s_service_account_name,
      annotations : {
        res : var.res_id,
        app : var.app_id,
        env : var.env_id
      }
    }
  }
  manifests = [
    {
      location = "namespace"
      data     = local.service_account_manifest
    }
  ]
}
