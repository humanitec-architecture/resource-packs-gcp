resource "google_pubsub_subscription_iam_member" "main" {
  subscription = var.subscription
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${var.service_account}"
}
