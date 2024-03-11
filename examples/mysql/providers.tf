terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.17"
    }
    humanitec = {
      source  = "humanitec/humanitec"
      version = "~> 1.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "humanitec" {}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = var.credentials

  default_labels = {
    "managed_by" = "terraform"
    "source"     = "github.com/humanitec-architecture/resource-pack-gcp"
  }
}
