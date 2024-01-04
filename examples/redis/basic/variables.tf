variable "humanitec_org_id" {
  type        = string
  description = "Humanitec organization where resource definitions will be applied"
}

variable "humanitec_token" {
  type        = string
  description = "Humanitec API token"
}

variable "humanitec_host" {
  type        = string
  default     = "https://api.humanitec.io"
  description = "Humanitec API host url"
}

variable "name" {
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

variable "auth_enabled" {
  type = bool
}
