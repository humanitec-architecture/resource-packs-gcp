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
  type = string
}

variable "credentials" {
  type = any
}

variable "memory_size_gb" {
  type = number
}

variable "location_id" {
  type = string
}

variable "alternative_location_id" {
  type = string
}

variable "authorized_network" {
  type = string
}

variable "display_name" {
  type = string
}

variable "redis_version" {
  type    = string
  default = "REDIS_4_0"
}

variable "reserved_ip_range" {
  type    = string
  default = null
}

variable "weekly_maintenance_windows" {
  type    = any
  default = {}
}

variable "auth_enabled" {
  type    = bool
  default = false
}
