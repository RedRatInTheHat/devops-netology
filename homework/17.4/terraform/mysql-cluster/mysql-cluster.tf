resource "yandex_mdb_mysql_cluster" "db" {
  name                = var.cluster_name
  environment         = var.environment
  network_id          = var.network_id
  version             = var.mysql_version

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type_id
    disk_size          = var.disk_size
  }

  dynamic "host" {
    for_each = var.is_HA == true ? range(var.number_of_hosts) : range(1)

    content {
        zone = element(var.subnets, host.value).zone
        subnet_id = element(var.subnets, host.value).id
        assign_public_ip = var.has_public_ip
    }
  }
}