variable "prefix" {
  type = string
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
  description = "GCP region"
  type        = string
}

variable "credentials" {
  description = "GCP credentials"
  type        = string
}

variable "managed_zone" {
  description = "The name of the zone in which this record set will reside."
  type        = string
}

variable "managed_zone_dns_name" {
  description = "The DNS name of the managed zone."
  type        = string
}
