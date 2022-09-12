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
  description = "Name for public resource yandex_dns_zone"
}

variable "dns-name-private" {
  type        = string
  default     = "reserdukov-private"
  description = "Name for private resource yandex_dns_zone"
}

variable "stage-zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone_id for stage"
}

variable "prod-zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Zone_id for prod"
}