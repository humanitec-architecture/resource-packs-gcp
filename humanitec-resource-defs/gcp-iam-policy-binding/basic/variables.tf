variable "prefix" {
  type = string
}

variable "name" {
  description = "Resource definition name"
  type        = string
}

variable "type" {
  description = "The type of binding that should be created, e.g. storage_bucket or pubsub_topic"
  type        = string
}

variable "scope_key" {
  description = "Type the scope is applied to, e.g. bucket or topic"
  type        = string
}

variable "scope_value" {
  description = "The name of the resource the scope is applied to, e.g. my-bucket or my-topic"
  type        = string
}

variable "role" {
  description = "The role to bind to the scope, e.g. roles/storage.admin or roles/pubsub.publisher"
  type        = string
}
