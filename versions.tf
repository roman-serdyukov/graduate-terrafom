terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

cloud {
    organization = "roman-serdyukov"
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
  cloud_id  = "b1gs4sjqbi3m84ii35ou"
  folder_id = "b1gu1oe1m0qlnkj61u6a"
  zone      = local.instance_zone_versions[terraform.workspace]
}