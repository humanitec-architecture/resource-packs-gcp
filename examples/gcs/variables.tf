variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "credentials" {
  description = "GCP credentials"
  type        = string
}

variable "location" {
  description = "The location of the bucket"
  type        = string
}

variable "humanitec_organization" {
  type = string
}

variable "humanitec_application" {
  type    = string
  default = "gcs-test"
}

variable "resource_packs_gcp_url" {
  description = "GCP Resource Pack git url"
  type        = string
  default     = "https://github.com/humanitec-architecture/resource-packs-gcp.git"
}

variable "resource_packs_gcp_rev" {
  description = "GCP Resource Pack git branch"
  type        = string
  default     = "refs/heads/main"
}
