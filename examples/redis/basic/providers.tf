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

provider "humanitec" {
  host   = var.humanitec_host
  org_id = var.humanitec_org_id
  token  = var.humanitec_token
}

provider "google" {
  project = var.project
  region  = var.region

  default_labels = {
    "managed_by" = "terraform"
    "source"     = "github.com/humanitec-architecture/resource-pack-gcp"
  }
}
