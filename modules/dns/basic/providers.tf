terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.10"
    }
  }

  required_version = ">= 1.3.0"
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = var.credentials

  default_labels = {
    "humanitec"  = "true"
    "hum-app"    = var.app_id
    "hum-env"    = var.env_id
    "hum-res"    = replace(var.res_id, ".", "-")
    "managed-by" = "terraform"
  }
}
