locals {
  vpc_ip_address_db1 = {
    stage = "192.168.99.31"
    prod  = "192.168.31.3"
  }
  vpc_subnet_id_db1 = {
    stage = "${yandex_vpc_subnet.all-subnet-a.id}"
    prod  = "${yandex_vpc_subnet.db-subnet-b.id}"
  }
  vpc_ip_address_db2 = {
    stage = "192.168.99.32"
    prod  = "192.168.31.4"
  }
  vpc_subnet_id_db2 = {
    stage = "${yandex_vpc_subnet.all-subnet-a.id}"
    prod  = "${yandex_vpc_subnet.db-subnet-b.id}"
  }
  instance_zone_mysql = {
    stage =  "ru-central1-a"
    prod  =  "ru-central1-b"
  }
}

resource "yandex_compute_instance" "db1" {
  name        = "db1"
  zone        = local.instance_zone_mysql[terraform.workspace]
  description = "VM for db repository"
  hostname    = "db1.reserdukov.ru"
  allow_stopping_for_update = true
  
  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32"
      size = "30"
    }
  }

  network_interface {
    subnet_id       = local.vpc_subnet_id_db1[terraform.workspace]
    ip_address      = local.vpc_ip_address_db1[terraform.workspace]
    }
  
  metadata = {
 #    ssh-keys = "ubuntu:${file(var.sshkey)}"
    ssh-keys = var.sshkey
    }
}

resource "yandex_compute_instance" "db2" {
  name        = "db2"
  zone        = local.instance_zone_mysql[terraform.workspace]
  description = "VM for db repository"
  hostname    = "db2.reserdukov.ru"
  allow_stopping_for_update = true
  
  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32"
      size = "30"
    }
  }

  network_interface {
    subnet_id       = local.vpc_subnet_id_db2[terraform.workspace]
    ip_address      = local.vpc_ip_address_db2[terraform.workspace]
    }
  
  metadata = {
#    ssh-keys = "ubuntu:${file(var.sshkey)}"
    ssh-keys = var.sshkey
    }
}