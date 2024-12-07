# VPC

resource "yandex_vpc_network" "vpc" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public" {
  name           = var.subnet_default_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.private_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

resource "yandex_vpc_subnet" "private-2" {
  name           = var.private_subnet_name_2
  zone           = var.zone_b
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.private_cidr_2
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

resource "yandex_vpc_subnet" "private-3" {
  name           = var.private_subnet_name_3
  zone           = var.zone_d
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.private_cidr_3
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}