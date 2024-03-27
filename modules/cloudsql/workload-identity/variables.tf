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

variable "instance" {
  type        = string
  description = "The name of the Cloud SQL instance."
}

variable "instance_connection_name" {
  type        = string
  description = "The connection name of the Cloud SQL instance."
}

variable "name" {
  type        = string
  description = "Resource name"
  default     = ""
}

variable "port" {
  type        = number
  description = "The port for the database (needs to match the database type)"
}
