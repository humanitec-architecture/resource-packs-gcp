resource "google_pubsub_topic_iam_member" "main" {
  topic  = var.topic
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:${var.service_account}"
}
