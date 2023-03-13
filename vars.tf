variable "sshkey" {
  type        = string
#  default     = "./id_rsa.netology.pub"
  description = "SSH key for VMs"
}

variable "cloud_id" {
  type        = string
  default     = ""
  description = "Cloud ID for YC"
}

variable "folder_id" {
  type        = string
  default     = ""
  description = "Folder ID for YC"
}

variable "family-image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image for instance"
}

variable "family-image-nat" {
  type        = string
  default     = "nat-instance-ubuntu"
  description = "Image ubuntu 18.04 nat instance"
}

variable "dns-zone" {
  type        = string
  default     = "your-domain."
  description = "Domain zone"
}

variable "dns-name" {
  type        = string
  default     = "dns-public"
  description = "Name for public resource yandex_dns_zone"
}

variable "dns-name-private" {
  type        = string
  default     = "dns-private"
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


variable "static" {
  type        = string
  default     = ""
  description = "Static IP addres in your network YC"
}
