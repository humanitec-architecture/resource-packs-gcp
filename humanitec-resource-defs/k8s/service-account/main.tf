resource "humanitec_resource_definition" "main" {
  id   = "${var.prefix}k8s-service-account"
  name = "${var.prefix}k8s-service-account"
  type = "k8s-service-account"

  driver_type = "humanitec/template"
  driver_inputs = {
    values_string = jsonencode({
      templates = {
        init      = ""
        manifests = <<EOL
serviceaccount.yaml:
  data:
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: $${resources.gcp-service-account.outputs.k8s_service_account_name}
      annotations:
        {{- if "$${resources.gcp-service-account.outputs.email}" }}
        iam.gke.io/gcp-service-account: $${resources.gcp-service-account.outputs.email}
        {{- end }}
        context: {{trimPrefix "modules." "$${context.res.id}"}}
        res: $${context.res.id}
        app: $${context.app.id}
        env: $${context.env.id}
  location: namespace
EOL
        outputs   = <<EOL
name: $${resources.gcp-service-account.outputs.k8s_service_account_name}
EOL
      }
    })
  }
}
