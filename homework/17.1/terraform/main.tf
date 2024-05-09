terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}
provider "docker" {
    host = "ssh://${var.remote-user}@${yandex_compute_instance.vm.network_interface[0].nat_ip_address}"
}

provider "yandex" {
  token     = var.oauth_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone_a
}

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

resource "yandex_compute_disk" "bd" {
  name     = "boot-disk"
  zone     = var.zone_a
  image_id = var.ubuntu-id
  size     = 20
}

#======virutal machine====
resource "yandex_compute_instance" "vm" {
  name                      = "docker-vm"
  allow_stopping_for_update = true
  zone                      = var.zone_a
  platform_id               = "standard-v3"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.bd.id
  }

  network_interface {
    subnet_id           = yandex_vpc_subnet.subnet-1.id
    nat                 = true
  }

  metadata = {
    user-data = "${file("${var.metadata-path}")}"
  }

  scheduling_policy {
    preemptible = true
  }
}