variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "name" {
  type        = string
  description = "Resource name"
  default     = ""
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
  description = "List of project-level roles to grant to the service account"
  type        = set(string)
}

variable "bindings" {
  description = "List of additional bindings to grant to the service account"
  type        = set(string)
}
