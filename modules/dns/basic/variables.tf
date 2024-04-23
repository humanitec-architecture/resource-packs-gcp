variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
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

variable "managed_zone" {
  description = "The name of the zone in which this record set will reside."
  type        = string
}

variable "ip_address" {
  description = "The IPv4 address that the DNS name should resolve to."
  type        = string
  default     = ""
}

variable "ipv6_address" {
  description = "The IPv6 address that the DNS name should resolve to."
  type        = string
  default     = ""
}

variable "name" {
  description = "A valid fully qualified domain name that the DNS name should resolve to."
  type        = string
  default     = ""
}

# TODO: Check if we want to also provide template support here.
variable "subdomain" {
  description = "The subdomain of the DNS name that the DNS record is for."
  type        = string
}
