# variables for yandex_compute_instance.platform

variable "vm_web_os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "The family name of an image. Used to search the latest image in a family."
}

variable "vm_web_instance_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name of created virtual machine."
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "The type of virtual machine to create."
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "CPU cores for the instance."
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Memory size in GB."
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 20
  description = "Baseline performance for a core as a percent."
}

variable "vm_web_is_preemptible" {
  type        = bool
  default     = true
  description = "Is the instance preemptible."
}

variable "vm_web_has_nat" {
  type        = bool
  default     = true
  description = "Is a public address provided."
}

variable "vm_web_has_access_to_console" {
  type        = number
  default     = 1
  description = "Is access to serial console enabled (0/1)"
}

# variables for yandex_compute_instance.netology-develop-platform-db

variable "vm_db_os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "The family name of an image. Used to search the latest image in a family."
}

variable "vm_db_instance_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name of created virtual machine."
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "The type of virtual machine to create."
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "CPU cores for the instance."
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "Memory size in GB."
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "Baseline performance for a core as a percent."
}

variable "vm_db_is_preemptible" {
  type        = bool
  default     = true
  description = "Is the instance preemptible."
}

variable "vm_db_has_nat" {
  type        = bool
  default     = true
  description = "Is a public address provided."
}

variable "vm_db_has_access_to_console" {
  type        = number
  default     = 1
  description = "Is access to serial console enabled (0/1)"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "The availability zone where the virtual machine will be created."
}

# virual machine

resource "yandex_compute_instance" "netology-develop-platform-db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone
  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_is_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-db.id
    nat       = var.vm_db_has_nat
  }

  metadata = {
    serial-port-enable = var.vm_db_has_access_to_console
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}