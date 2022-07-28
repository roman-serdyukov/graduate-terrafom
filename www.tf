resource "yandex_compute_instance" "www" {
  name        = "www"
  zone        = "ru-central1-b"
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
    subnet_id       = "${yandex_vpc_subnet.webapps-subnet-b.id}"
    ip_address      = "192.168.5.3"
    }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.reserdukov@gmail.com.pub")}"
    }
}