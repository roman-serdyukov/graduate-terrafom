resource "yandex_dns_zone" "reserdukov" {
  name        = "reserdukov"
  description = "My zone for thesis"

  labels = {
    label1 = "netology"
  }

  zone             = "reserdukov.ru."
  public           = false
  private_networks = [yandex_vpc_network.webapps.id]
}

resource "yandex_dns_recordset" "alertmanager" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "alertmanager.reserdukov.ru."
  type    = "CNAME"
  ttl     = 200
  data    = ["monitoring"]
}

resource "yandex_dns_recordset" "prometheus" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "prometheus.reserdukov.ru."
  type    = "CNAME"
  ttl     = 200
  data    = ["monitoring"]
}

resource "yandex_dns_recordset" "grafana" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "grafana.reserdukov.ru."
  type    = "CNAME"
  ttl     = 200
  data    = ["monitoring"]
}
/*
resource "yandex_dns_recordset" "www" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "www.reserdukov.ru."
  type    = "A"
  ttl     = 200
  data    = ["192.168.5.3"]
}

resource "yandex_dns_recordset" "gitlab" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "gitlab.reserdukov.ru."
  type    = "A"
  ttl     = 200
  data    = ["192.168.6.3"]
}


resource "yandex_dns_recordset" runner" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "runner.reserdukov.ru."
  type    = "A"
  ttl     = 200
  data    = ["192.168.6.4"]
}

resource "yandex_dns_recordset" "db1" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "db1.reserdukov.ru."
  type    = "A"
  ttl     = 200
  data    = ["192.168.31.3"]
}

resource "yandex_dns_recordset" "db2" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "db2.reserdukov.ru."
  type    = "A"
  ttl     = 200
  data    = ["192.168.31.4"]
}

resource "yandex_dns_recordset" "reverse" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "reverse.reserdukov.ru."
  type    = "A"
  ttl     = 200
  data    = ["192.168.100.3"]
}

resource "yandex_dns_recordset" "alertmanager" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "alertmanager.reserdukov.ru."
  type    = "A"
  ttl     = 200
  data    = ["192.168.8.3"]
}

resource "yandex_dns_recordset" "prometheus" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "prometheus.reserdukov.ru."
  type    = "A"
  ttl     = 200
  data    = ["192.168.8.4"]
}

resource "yandex_dns_recordset" "grafana" {
  zone_id = yandex_dns_zone.reserdukov.id
  name    = "grafana.reserdukov.ru."
  type    = "A"
  ttl     = 200
  data    = ["192.168.8.5"]
}
*/