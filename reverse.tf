locals {
  vpc_ip_address_reverse = {
    stage = "192.168.99.254"
    prod  = "192.168.100.3"
  }
  vpc_subnet_id_reverse = {
    stage = "${yandex_vpc_subnet.all-subnet-a.id}"
    prod  = "${yandex_vpc_subnet.reverse-subnet-b.id}"
  }
  instance_zone_reverse = {
    stage =  var.stage-zone
    prod  =  var.prod-zone
  }
 }

resource "yandex_compute_instance" "reverse" {
  name                      = "reverce"
  zone                      = local.instance_zone_reverse[terraform.workspace]
  description               = "VM for reverce proxy"
  hostname                  = "reverse.reserdukov.ru"
  allow_stopping_for_update = true
    
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.image-instance-nat.id}"
#      image_id = "fd82fnsvr0bgt1fid7cl" # ubuntu 18.04 nat instance
      size     = "20"
    }
  }

  network_interface {
    subnet_id       = local.vpc_subnet_id_reverse[terraform.workspace]
    ip_address      = local.vpc_ip_address_reverse[terraform.workspace]
    nat_ip_address  = yandex_vpc_address.static.external_ipv4_address[0].address
    nat             = true
  }

  metadata = {
#    ssh-keys = "ubuntu:${file(var.sshkey)}"
    ssh-keys = var.sshkey
    }
}
