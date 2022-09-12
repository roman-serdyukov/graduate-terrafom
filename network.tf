resource "yandex_vpc_network" "webapps" {
    name = "webapps"
}

resource "yandex_vpc_subnet" "all-subnet-a" {
    name           = "webapps-subnet-a"
    v4_cidr_blocks = ["192.168.99.0/24"]
    zone           = var.stage-zone
    network_id     = "${yandex_vpc_network.webapps.id}"
    route_table_id = "${yandex_vpc_route_table.inet-route-stage.id}"
}

resource "yandex_vpc_subnet" "apps-subnet-b" {
    name           = "apps-subnet-b"
    v4_cidr_blocks = ["192.168.5.0/28"]
    zone           = var.prod-zone
    network_id     = "${yandex_vpc_network.webapps.id}"
    route_table_id = "${yandex_vpc_route_table.inet-route.id}"
}

resource "yandex_vpc_subnet" "gitlab-subnet-b" {
    name            = "gitlab-subnet-b"
    v4_cidr_blocks = ["192.168.6.0/28"]
    zone           = var.prod-zone
    network_id     = "${yandex_vpc_network.webapps.id}"
    route_table_id = "${yandex_vpc_route_table.inet-route.id}"
}
resource "yandex_vpc_subnet" "reverse-subnet-b" {
    name           = "reverse-subnet-b"
    v4_cidr_blocks = ["192.168.100.0/28"]
    zone           = "ru-central1-b"
    network_id     = "${yandex_vpc_network.webapps.id}"
}

resource "yandex_vpc_subnet" "monitoring-subnet-b" {
    name           = "monitoring-subnet-b"
    v4_cidr_blocks = ["192.168.8.0/28"]
    zone           = var.prod-zone
    network_id     = "${yandex_vpc_network.webapps.id}"
    route_table_id = "${yandex_vpc_route_table.inet-route.id}"
}

resource "yandex_vpc_subnet" "db-subnet-b" {
    name           = "db-subnet-b"
    v4_cidr_blocks = ["192.168.31.0/28"]
    zone           = var.prod-zone
    network_id     = "${yandex_vpc_network.webapps.id}"
    route_table_id = "${yandex_vpc_route_table.inet-route.id}"
}

resource "yandex_vpc_route_table" "inet-route" {
    name        = "inet"
    network_id  = "${yandex_vpc_network.webapps.id}"

    static_route {
        destination_prefix = "0.0.0.0/0"
        next_hop_address   = "192.168.100.3"
  }
}

resource "yandex_vpc_route_table" "inet-route-stage" {
    name        = "inet-stage"
    network_id  = "${yandex_vpc_network.webapps.id}"

    static_route {
        destination_prefix = "0.0.0.0/0"
        next_hop_address   = "192.168.99.254"
  }
}

locals {
  instance_zone_network = {
  stage =  var.stage-zone
  prod  =  var.prod-zone
  }
}

resource "yandex_vpc_address" "static" {
  name = "static"
  external_ipv4_address {
    zone_id = local.instance_zone_network[terraform.workspace]
  }
}