variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "project" {
  description = "GCP project"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "credentials" {
  description = "GCP credentials"
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

variable "name" {
  type        = string
  description = "Resource name"
  default     = ""
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

variable "redis_version" {
  type    = string
  default = "REDIS_4_0"
}

variable "display_name" {
  type        = string
  description = "Resource display name"
  default     = ""
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
