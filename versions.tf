terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

cloud {
    organization = "roman-serdyukov"
    hostname = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["prod"]
    }
  }
}

provider "yandex" {
  cloud_id                 = "b1gs4sjqbi3m84ii35ou"
  folder_id                = "b1gu1oe1m0qlnkj61u6a"
  zone                     = "ru-central1-a"
}