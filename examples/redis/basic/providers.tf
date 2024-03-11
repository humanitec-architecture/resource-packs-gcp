terraform {
  required_providers {
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
