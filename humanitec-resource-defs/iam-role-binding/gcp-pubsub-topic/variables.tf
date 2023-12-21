variable "prefix" {
  type = string
}

variable "name" {
  description = "Resource definition name"
  type        = string
}

variable "role" {
  description = "The role to bind to the gcp-pubsub-topic resource"
  type        = string
}

variable "gcp_pubsub_topic_resource_class" {
  description = "The class of the gcp-pubsub-topic resource"
  type        = string
}
