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

  # TODO
  default_labels = {
    "managed-by" = "humanitec"
    "hum-app-id" = var.app_id
    "hum-env-id" = var.env_id
    # "hum-res-id" = var.res_id
  }
}
