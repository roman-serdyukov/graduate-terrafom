resource "yandex_dns_zone" "cloud_dns" {
  name        = var.dns-name
  description = "My zone for graduation project"

  labels = {
    label1 = "netology"
  }

  zone             = var.dns-zone
  public           = false
  private_networks = [yandex_vpc_network.webapps.id]
}

resource "yandex_dns_recordset" "alertmanager" {
  zone_id = yandex_dns_zone.cloud_dns.id
  name    = "alertmanager.reserdukov.ru."
  type    = "CNAME"
  ttl     = 200
  data    = ["monitoring"]
}

resource "yandex_dns_recordset" "prometheus" {
  zone_id = yandex_dns_zone.cloud_dns.id
  name    = "prometheus.reserdukov.ru."
  type    = "CNAME"
  ttl     = 200
  data    = ["monitoring"]
}

resource "yandex_dns_recordset" "grafana" {
  zone_id = yandex_dns_zone.cloud_dns.id
  name    = "grafana.reserdukov.ru."
  type    = "CNAME"
  ttl     = 200
  data    = ["monitoring"]
}