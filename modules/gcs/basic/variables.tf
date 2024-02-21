variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "name" {
  type        = string
  description = "Resource name"
  default     = ""
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

variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "credentials" {
  description = "GCP credentials"
  type        = string
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket when deleting"
  type        = bool
  default     = false
}

variable "location" {
  description = "The location of the bucket"
  type        = string
}
