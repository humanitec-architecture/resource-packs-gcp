variable "prefix" {
  description = "Prefix for all resources"
  type        = string
}

variable "resource_packs_gcp_rev" {
  type    = string
  default = "ref/heads/main"
}

variable "resource_packs_gcp_url" {
  type    = string
  default = "https://github.com/humanitec-architecture/resource-packs-gcp.git"
}

variable "append_logs_to_error" {
  description = "Append Terraform logs to error messages."
  type        = bool
  default     = false
}

variable "driver_account" {
  description = "The ID of the Resource Account which should be used."
  type        = string
}

variable "project" {
  type = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "name" {
  type        = string
  description = "Resource name (can contain placeholders like $${context.app.id})"
  default     = ""
}

variable "instance_resource" {
  description = "Identifier of the PostgreSQL instance resource."
  type        = string
}
