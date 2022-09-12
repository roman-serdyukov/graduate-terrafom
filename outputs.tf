output "external_ip_address_reverse" {
  value = yandex_vpc_address.static.external_ipv4_address[0].address
  description = "External IP"
}