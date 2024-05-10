# Network

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# NAT

resource "yandex_vpc_gateway" "nat_gateway" {
  name = var.gateway_name
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = var.route_table_name
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = var.destination_prefix
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

# Subnet

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}
resource "yandex_vpc_subnet" "develop-db" {
  name           = var.vm_db_zone
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.b_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}


# VM

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_os_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_is_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_has_nat
  }

  metadata = var.metadata
}
