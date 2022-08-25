variable "static" {
  type        = string
  description = "Static IP addres in your network YC"
}

variable "sshkey" {
  type        = string
#  default     = "./id_rsa.netology.pub"
  description = "SSH key for VMs"
}

variable "dns-zone" {
  type        = string
  default     = "reserdukov.ru."
  description = "Domain zone"
}

variable "dns-name" {
  type        = string
  default     = "reserdukov"
  description = "Name for resource yandex_dns_zone"
}