variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "managed_zone" {
  description = "The name of the zone in which this record set will reside."
  type        = string
}

variable "name" {
  description = "Name of the example application"
  type        = string
  default     = "hum-rp-dns-example"
}

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

variable "prefix" {
  description = "Prefix of the created resources"
  type        = string
  default     = "hum-rp-dns-ex-"
}
