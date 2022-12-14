resource "yandex_dns_zone" "private_dns" {
  name             = var.dns-name-private
  description      = "My private zone for graduation project"

  labels = {
    label1         = "private-netology"
  }

  zone             = var.dns-zone
  public           = false
  private_networks = [yandex_vpc_network.webapps.id]
}

resource "yandex_dns_zone" "cloud_dns" {
  name             = var.dns-name
  description      = "My public zone for graduation project"

  labels = {
    label1         = "public-netology"
  }

  zone             = var.dns-zone
  public           = true
}

resource "yandex_dns_recordset" "root" {
  zone_id          = yandex_dns_zone.cloud_dns.id
  name             = "${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "www" {
  zone_id          = yandex_dns_zone.cloud_dns.id
  name             = "www.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "gitlab" {
  zone_id          = yandex_dns_zone.cloud_dns.id
  name             = "gitlab.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "grafana" {
  zone_id          = yandex_dns_zone.cloud_dns.id
  name             = "grafana.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "prometheus" {
  zone_id          = yandex_dns_zone.cloud_dns.id
  name             = "prometheus.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "alertmanager" {
  zone_id          = yandex_dns_zone.cloud_dns.id
  name             = "alertmanager.${var.dns-zone}"
  type             = "A"
  ttl              = 200
  data             = [yandex_vpc_address.static.external_ipv4_address[0].address]
}
