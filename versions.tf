terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


locals {
  instance_zone_versions = {
  stage =  var.stage-zone
  prod  =  var.prod-zone
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone      = local.instance_zone_versions[terraform.workspace]
}