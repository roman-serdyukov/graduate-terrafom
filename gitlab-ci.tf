locals {
  vpc_ip_address_gitlab = {
    stage = "192.168.99.10"
    prod  = "192.168.6.3"
  }
  vpc_subnet_id_gitlab = {
    stage = "${yandex_vpc_subnet.all-subnet-a.id}"
    prod  = "${yandex_vpc_subnet.gitlab-subnet-b.id}"
  }
  vpc_ip_address_runner = {
    stage = "192.168.99.11"
    prod  = "192.168.6.4"
  }
  vpc_subnet_id_runner = {
    stage = "${yandex_vpc_subnet.all-subnet-a.id}"
    prod  = "${yandex_vpc_subnet.gitlab-subnet-b.id}"
  }
  instance_zone_gitlab = {
    stage =  "ru-central1-a"
    prod  =  "ru-central1-b"
  }
}

resource "yandex_compute_instance" "gitlab" {
  name        = "gitlab"
  zone        = local.instance_zone_gitlab[terraform.workspace]
  description = "VM for gitlab repository"
  hostname    = "gitlab.reserdukov.ru"
  allow_stopping_for_update = true
  
  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32"
      size = "30"
    }
  }

  network_interface {
    subnet_id       = local.vpc_subnet_id_gitlab[terraform.workspace]
    ip_address      = local.vpc_ip_address_gitlab[terraform.workspace]
    }

  metadata = {
#    ssh-keys = "ubuntu:${file(var.sshkey)}"
    ssh-keys = var.sshkey
    }
}

resource "yandex_compute_instance" "runner" {
  name        = "runner"
  zone        = local.instance_zone_gitlab[terraform.workspace]
  description = "VM for gitlab repository"
  hostname    = "runner.reserdukov.ru"
  allow_stopping_for_update = true
  
  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32"
      size = "20"
    }
  }

  network_interface {
    subnet_id       = local.vpc_subnet_id_runner[terraform.workspace]
    ip_address      = local.vpc_ip_address_runner[terraform.workspace]
  }

  metadata = {
#    ssh-keys = "ubuntu:${file(var.sshkey)}"
    ssh-keys = var.sshkey
   }
}