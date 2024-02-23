variable "prefix" {
  type = string
}

variable "name" {
  description = "Resource definition name"
  type        = string
}

variable "role" {
  description = "The role to bind to the gcp-pubsub-subscription resource"
  type        = string
}

variable "gcp_pubsub_subscription_resource_class" {
  description = "The class of the gcp-pubsub-subscription resource"
  type        = string
}
