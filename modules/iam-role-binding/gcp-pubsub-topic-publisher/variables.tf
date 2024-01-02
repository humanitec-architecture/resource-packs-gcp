variable "topic" {
  description = "The topic name to bind to attach IAM policy to."
  type        = string
}

variable "service_account" {
  type = string
}

variable "app_id" {
  type = string
}

variable "env_id" {
  type = string
}

# variable "res_id" {
#   type = string
# }

variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "credentials" {
  description = "GCP credentials"
  type        = string
}
