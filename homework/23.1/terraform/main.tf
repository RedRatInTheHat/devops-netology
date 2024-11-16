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

# NAT

## Boot Disks

resource "yandex_compute_disk" "boot-disk-nat" {
  name     = var.nat_boot_disk_name
  type     = var.boot_disk_type
  zone     = var.default_zone
  size     = var.boot_disk_size
  image_id = var.nat_boot_disk_image_id
}

resource "yandex_compute_disk" "boot-disk-public-vm" {
  name     = var.vm_boot_disk_name
  type     = var.boot_disk_type
  zone     = var.default_zone
  size     = var.boot_disk_size
  image_id = var.vm_boot_disk_image_id
}

## Security Group

resource "yandex_vpc_security_group" "nat-instance-sg" {
  name       = var.sg_nat_name
  network_id = yandex_vpc_network.vpc.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}


## VM

resource "yandex_compute_instance" "nat-instance" {
  name        = var.vm_nat_name
  platform_id = var.platform_id
  zone        = var.default_zone

  allow_stopping_for_update = var.allow_stopping_for_update

  resources {
    core_fraction = var.core_fraction
    cores         = var.cores
    memory        = var.memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-nat.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat                = true
    ip_address         = var.nat_ip_address
  }

  metadata = {
    user-data = "${file("${var.metadata-path}")}"
  }
}

# Public VM
resource "yandex_compute_instance" "public-vm" {
  name        = var.public_vm_name
  platform_id = var.platform_id
  zone        = var.default_zone

  allow_stopping_for_update = var.allow_stopping_for_update

  resources {
    core_fraction = var.core_fraction
    cores         = var.cores
    memory        = var.memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-public-vm.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
  }

  metadata = {
    user-data = "${file("${var.metadata-path}")}"
  }
}


