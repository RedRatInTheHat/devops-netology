# ========master
resource "yandex_compute_disk" "master-bd" {
  name     = "master-boot-disk"
  zone     = var.zone_a
  image_id = var.ubuntu-id
  size     = 20
}

resource "yandex_compute_instance" "master-vm" {
  name                      = "master"
  allow_stopping_for_update = true
  zone                      = var.zone_a
  platform_id               = "standard-v3"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.master-bd.id
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

# ====== slave1
resource "yandex_compute_disk" "slave-bd-1" {
  name     = "slave-boot-disk-1"
  zone     = var.zone_a
  image_id = var.ubuntu-id
  size     = 20
}

resource "yandex_compute_instance" "slave-vm-1" {
  name                      = "slave-1"
  allow_stopping_for_update = true
  zone                      = var.zone_a
  platform_id               = "standard-v3"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.slave-bd-1.id
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


# ====== slave2
resource "yandex_compute_disk" "slave-bd-2" {
  name     = "slave-boot-disk-2"
  zone     = var.zone_a
  image_id = var.ubuntu-id
  size     = 20
}

resource "yandex_compute_instance" "slave-vm-2" {
  name                      = "slave2"
  allow_stopping_for_update = true
  zone                      = var.zone_a
  platform_id               = "standard-v3"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.slave-bd-2.id
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