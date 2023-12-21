variable "prefix" {
  type = string
}

variable "app_id" {
  type = string
}

variable "env_id" {
  type = string
}

variable "res_id" {
  type = string
}

variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "credentials" {
  description = "GCP credentials"
  type        = string
}

variable "namespace" {
  description = "k8s namespace"
  type        = string
}

variable "roles" {
  description = "List of roles to assign to the service account"
  type        = set(string)
}
