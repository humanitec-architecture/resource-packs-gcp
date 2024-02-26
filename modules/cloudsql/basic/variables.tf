variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "project" {
  description = "GCP project ID"
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

variable "database_version" {
  type        = string
  description = "The MySQL, PostgreSQL or SQL Server version to use."
}

variable "tier" {
  type        = string
  description = "The machine type to use."
}

variable "private_network" {
  type        = string
  description = "The VPC network from which the Cloud SQL instance is accessible for private IP."
}

variable "port" {
  type        = number
  description = "The port for the database (needs to match the database type)"
}
