terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

cloud {
#    organization = "roman-serdyukov"
    organization = "your_company"
    hostname     = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["prod"]
    }
  }
}

locals {
  instance_zone_versions = {
  stage =  var.stage-zone
  prod  =  var.prod-zone
  }
}

provider "yandex" {
#  cloud_id                 = var.cloud_id
#  folder_id                = var.folder_id
  zone      = local.instance_zone_versions[terraform.workspace]
}