variable "name" {
  description = "Name of the example application"
  type        = string
  default     = "hum-rp-mysql-example"
}

variable "resource_packs_gcp_rev" {
  type    = string
  default = "refs/heads/main"
}

variable "resource_packs_gcp_url" {
  type    = string
  default = "https://github.com/humanitec-architecture/resource-packs-gcp.git"
}

variable "prefix" {
  description = "Prefix of the created resources"
  type        = string
  default     = "hum-rp-mysql-ex-"
}

variable "project" {
  type = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "private_network" {
  type        = string
  description = "The VPC network from which the Cloud SQL instance is accessible for private IP."
}
