terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1"
    }
  }

  required_version = ">= 1.3.0"
}

provider "google" {
  project     = var.project
  credentials = var.credentials

  default_labels = {
    "humanitec"  = "true"
    "hum-app-id" = var.app_id
    "hum-env-id" = var.env_id
    "hum-res-id" = replace(var.res_id, ".", "-")
  }
}
