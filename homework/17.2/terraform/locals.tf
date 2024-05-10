locals {
    vm_web_name = "${var.vm_web_instance_name}-${var.default_zone}"
    vm_db_name  = "${var.vm_db_instance_name}-${var.vm_db_zone}"
}