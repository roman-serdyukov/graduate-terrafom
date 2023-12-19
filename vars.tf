variable "sshkey" {
  type        = string
  default     = "your_key"
  description = "SSH key for VMs"
}

variable "cloud_id" {
  type        = string
  default     = "your_cloud"
  description = "Cloud ID for YC"
}

variable "folder_id" {
  type        = string
  default     = "your_folder"
  description = "Folder ID for YC"
}

variable "family-image" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "Image for instance"
}

variable "user" {
  type        = string
  default     = "yc-user"
  description = "User instance"
}

variable "family-image-nat" {
  type        = string
  default     = "nat-instance-ubuntu"
  description = "Image ubuntu 18.04 nat instance"
}

variable "dns-zone" {
  type        = string
  default     = "your_domain."
  description = "Domain zone"
}

variable "dns-name" {
  type        = string
  default     = "public"
  description = "Name for public resource yandex_dns_zone"
}

variable "dns-name-private" {
  type        = string
  default     = "private"
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
