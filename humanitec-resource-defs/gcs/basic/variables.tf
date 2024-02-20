variable "resource_packs_gcp_url" {
  description = "GCP Resource Pack git url"
  type        = string
  default     = "https://github.com/humanitec-architecture/resource-packs-gcp.git"
}

variable "resource_packs_gcp_rev" {
  description = "GCP Resource Pack git ref"
  type        = string
  default     = "refs/heads/main"
}

variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "credentials" {
  description = "GCP credentials"
  type        = string
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket when deleting"
  type        = bool
  default     = false
}

variable "location" {
  description = "The location of the bucket"
  type        = string
}

variable "prefix" {
  description = "Prefix for all resources"
  type        = string
}

variable "name" {
  type        = string
  description = "Resource name (can contain placeholders like $${context.app.id})"
  default     = ""
}
