terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = "1.0.35"
    }
  }
}

provider "intersight" {
  apikey    = var.intersight_apikey
  secretkey = var.intersight_secretkey
  endpoint  = "https://intersight.com"
}