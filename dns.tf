resource "yandex_dns_zone" "private" {
  name             = "${var.dns-name-private}"
  description      = "My private zone for graduation project"

  labels = {
    label1         = "private-netology"
  }

  zone             = var.dns-zone
  public           = false
  private_networks = [yandex_vpc_network.webapps.id]
}

resource "yandex_dns_zone" "cloud" {
  name             = "${var.dns-name}"
  description      = "My public zone for graduation project"

  labels = {
    label1         = "public-netology"
  }

  zone             = var.dns-zone
  public           = true
}

resource "yandex_dns_recordset" "root" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "www" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "www.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "gitlab" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "gitlab.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "runner" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "runner.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "grafana" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "grafana.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "prometheus" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "prometheus.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "alertmanager" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "alertmanager.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "monitoring" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "monitoring.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "db1" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "db1.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "db2" {
  zone_id          = yandex_dns_zone.cloud.id
  name             = "db2.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}