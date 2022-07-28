resource "yandex_compute_instance" "db1" {
  name        = "db1"
  zone        = "ru-central1-b"
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
    subnet_id       = "${yandex_vpc_subnet.db-subnet-b.id}"
    ip_address      = "192.168.31.3"
    }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.reserdukov@gmail.com.pub")}"
    }
}

resource "yandex_compute_instance" "db2" {
  name        = "db2"
  zone        = "ru-central1-b"
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
      size = "20"
    }
  }

  network_interface {
    subnet_id   = "${yandex_vpc_subnet.db-subnet-b.id}"
    ip_address  = "192.168.31.4"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.reserdukov@gmail.com.pub")}"
    }
}