data "yandex_compute_image" "image-instance" {
  family = var.family-image
}

data "yandex_compute_image" "image-instance-nat" {
  family = var.family-image-nat
}