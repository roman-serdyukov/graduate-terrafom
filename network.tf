resource "yandex_vpc_network" "devops-net" {
    name = "webapps"
}

resource "yandex_vpc_subnet" "webapps-subnet-a" {
    name           = "webapps-subnet-a"
    v4_cidr_blocks = ["192.168.99.0/24"]
    zone           = "ru-central1-a"
    network_id     = "${yandex_vpc_network.devops-net.id}"
}

resource "yandex_vpc_subnet" "webapps-subnet-b" {
    name           = "webapps-subnet-b"
    v4_cidr_blocks = ["192.168.5.0/28"]
    zone           = "ru-central1-b"
    network_id     = "${yandex_vpc_network.devops-net.id}"
}

resource "yandex_vpc_subnet" "gitlab-subnet-b" {
    name            = "gitlab-subnet-b"
    v4_cidr_blocks = ["192.168.6.0/28"]
    zone           = "ru-central1-b"
    network_id     = "${yandex_vpc_network.devops-net.id}"
}
resource "yandex_vpc_subnet" "reverse-subnet-b" {
    name           = "reverse-subnet-b"
    v4_cidr_blocks = ["192.168.100.0/28"]
    zone           = "ru-central1-b"
    network_id     = "${yandex_vpc_network.devops-net.id}"
}

resource "yandex_vpc_subnet" "monitoring-subnet-b" {
    name           = "monitoring-subnet-b"
    v4_cidr_blocks = ["192.168.8.0/28"]
    zone           = "ru-central1-b"
    network_id     = "${yandex_vpc_network.devops-net.id}"
}

resource "yandex_vpc_subnet" "db-subnet-b" {
    name           = "db-subnet-b"
    v4_cidr_blocks = ["192.168.31.0/28"]
    zone           = "ru-central1-b"
    network_id     = "${yandex_vpc_network.devops-net.id}"
}