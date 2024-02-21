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

variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "credentials" {
  type = string
}

variable "name" {
  type        = string
  description = "Resource name (can contain placeholders like $${context.app.id})"
  default     = ""
}

variable "database_version" {
  type        = string
  description = "The MySQL, PostgreSQL or SQL Server version to use."
}

variable "tier" {
  type        = string
  description = "The machine type to use."
}

variable "private_network" {
  type        = string
  description = "The VPC network from which the Cloud SQL instance is accessible for private IP."
}
