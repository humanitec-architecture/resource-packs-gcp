variable "prefix" {
  type = string
}

variable "name" {
  type    = string
  default = ""
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

variable "topic_name" {
  description = "Name of the topic resource"
  type        = string
}
