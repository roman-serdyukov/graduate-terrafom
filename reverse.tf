resource "yandex_compute_instance" "reverse" {
  name        = "reverce"
  zone        = "ru-central1-b"
  description = "VM for reverce proxy"
  hostname    = "reverse.reserdukov.ru"
  allow_stopping_for_update = true
    
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32"
      size = "20"
    }
  }

  network_interface {
    subnet_id      = "${yandex_vpc_subnet.reverse-subnet-b.id}"
    ip_address     = "192.168.100.3"
    nat_ip_address = "51.250.111.49"
    nat            = true
  }

  metadata = {
#    user-data = "${file("./meta.txt")}"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.reserdukov@gmail.com.pub")}"
    }
}
