resource "google_pubsub_subscription" "main" {
  name  = var.prefix
  topic = var.topic_name
}
