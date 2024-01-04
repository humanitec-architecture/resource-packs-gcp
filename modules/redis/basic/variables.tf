variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "credentials" {
  type = any
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
  type = string
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
  type = string
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
