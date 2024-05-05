resource "yandex_vpc_network" "network" {
  name = "network1"
}

#=====subnet====
resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = var.zone_a
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = yandex_vpc_network.network.id
}