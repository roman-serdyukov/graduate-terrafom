locals {
  vpc_ip_address_monitoring = {
    stage = "192.168.99.8"
    prod  = "192.168.8.3"
  }
  vpc_subnet_id_monitoring = {
    stage = "${yandex_vpc_subnet.all-subnet-a.id}"
    prod  = "${yandex_vpc_subnet.monitoring-subnet-b.id}"
  }
  instance_zone_monitoring = {
    stage =  var.stage-zone
    prod  =  var.prod-zone
  }
}

resource "yandex_compute_instance" "monitoring" {
  name        = "monitoring"
  zone        = local.instance_zone_monitoring[terraform.workspace]
  description = "VM for monitoring"
  hostname    = "monitoring.${var.dns-zone}"
  allow_stopping_for_update = true
  
  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.image-instance.id}"
#      image_id = "fd81hgrcv6lsnkremf32"
      size     = "30"
    }
  }

  network_interface {
    subnet_id   = local.vpc_subnet_id_monitoring[terraform.workspace]
    ip_address  = local.vpc_ip_address_monitoring[terraform.workspace]
    }

  metadata = {
    ssh-keys = "${var.user}:${file(var.sshkey)}"
   }
}