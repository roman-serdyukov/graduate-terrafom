locals {
  vpc_ip_address_www = {
    stage = "192.168.99.5"
    prod  = "192.168.5.3"
  }
  vpc_subnet_id_www = {
    stage = "${yandex_vpc_subnet.all-subnet-a.id}"
    prod  = "${yandex_vpc_subnet.apps-subnet-b.id}"
  }
  instance_zone_www = {
    stage =  "ru-central1-a"
    prod  =  "ru-central1-b"
  }
}

resource "yandex_compute_instance" "www" {
  name        = "www"
  zone        = local.instance_zone_www[terraform.workspace]
  description = "VM for gitlab repository"
  hostname    = "www.reserdukov.ru"
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
    subnet_id       = local.vpc_subnet_id_www[terraform.workspace]
    ip_address      = local.vpc_ip_address_www[terraform.workspace]
    }
    
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.netology.pub")}"
    }
}
