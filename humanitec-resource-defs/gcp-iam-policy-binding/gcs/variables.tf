variable "prefix" {
  type = string
}

variable "name" {
  description = "Resource definition name"
  type        = string
}

variable "role" {
  description = "The role to bind to the GCS resource"
  type        = string
}

variable "gcs_resource_class" {
  description = "The class of the GCS resource"
  type        = string
}
