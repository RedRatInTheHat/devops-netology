resource "yandex_compute_instance" "web" {
  count                     = var.vm_web_count
  name                      = "${var.vm_web_instance_name}-${count.index + 1}"
  allow_stopping_for_update = var.vm_allow_stopping_for_update
  depends_on                = [ yandex_compute_instance.db ]

  platform_id = var.vm_platform_id

  metadata = local.metadata

  resources {
    cores         = var.vm_web_resources.cores
    memory        = var.vm_web_resources.memory
    core_fraction = var.vm_web_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_is_preemptible
  }

  network_interface {
    subnet_id           = yandex_vpc_subnet.develop.id
    nat                 = var.vm_has_nat
    security_group_ids  = [ yandex_vpc_security_group.example.id ]
  }
}