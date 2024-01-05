variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  type = string
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

variable "app_name" {
  type    = string
  default = "dns-test"
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
