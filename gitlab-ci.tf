resource "yandex_compute_instance" "gitlab" {
  name        = "gitlab"
  zone        = "ru-central1-b"
  description = "VM for gitlab repository"
  hostname    = "gitlab.reserdukov.ru"
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
    subnet_id = "${yandex_vpc_subnet.gitlab-subnet-b.id}"
    ip_address = "192.168.6.3"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.reserdukov@gmail.com.pub")}"
    }
}

resource "yandex_compute_instance" "runner" {
  name        = "runner"
  zone        = "ru-central1-b"
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
    subnet_id   = "${yandex_vpc_subnet.gitlab-subnet-b.id}"
    ip_address  = "192.168.6.4"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.reserdukov@gmail.com.pub")}"
    }
}