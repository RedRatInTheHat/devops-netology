resource "yandex_compute_instance" "db" {
  for_each                  = { for vm in var.each_vm:  vm.vm_name => vm }
  name                      = each.value.vm_name
  allow_stopping_for_update = var.vm_allow_stopping_for_update

  platform_id = var.vm_platform_id

  metadata = local.metadata
  
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id  = data.yandex_compute_image.ubuntu.image_id
      size      = each.value.disk_volume
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