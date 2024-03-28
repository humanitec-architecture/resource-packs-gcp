variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "resource_packs_gcp_url" {
  description = "GCP Resource Pack git url"
  type        = string
  default     = "https://github.com/humanitec-architecture/resource-packs-gcp.git"
}

variable "resource_packs_gcp_rev" {
  description = "GCP Resource Pack git ref"
  type        = string
  default     = "refs/heads/main"
}

variable "name" {
  description = "Name of the example application"
  type        = string
  default     = "hum-rp-gcp-pubsub-example"
}

variable "prefix" {
  type    = string
  default = "hum-rp-gcp-pubsub-ex-"
}
