resource "yandex_mdb_mysql_cluster" "mysql-cluster" {
  name                = var.mysql_cluster_name
  environment         = var.mysql_environment
  network_id          = yandex_vpc_network.vpc.id
  version             = var.mysql_version
  security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]
  deletion_protection = var.mysql_deletion_protection

  resources {
    resource_preset_id = var.mysql_resource_preset_id
    disk_type_id       = var.mysql_disk_type_id
    disk_size          = var.mysql_disk_size
  }

  maintenance_window {
    type = var.mysql_maintenance_window_type
  }

  backup_window_start {
    hours   = var.mysql_backup_window_start_hours
    minutes = var.mysql_backup_window_start_minutes
  }

  host {
    zone             = var.default_zone
    subnet_id        = yandex_vpc_subnet.private.id
    assign_public_ip = var.mysql_host_assign_public_ip
  }

  host {
    zone             = var.zone_b
    subnet_id        = yandex_vpc_subnet.private-2.id
    assign_public_ip = var.mysql_host_assign_public_ip
  }

  host {
    zone             = var.zone_d
    subnet_id        = yandex_vpc_subnet.private-3.id
    assign_public_ip = var.mysql_host_assign_public_ip
  }
}

resource "yandex_mdb_mysql_database" "netology-db" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-cluster.id
  name       = var.mysql_database_name
}

resource "yandex_mdb_mysql_user" "sqler" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-cluster.id
  name       = var.mysql_user_name
  password   = var.mysql_user_password
  permission {
    database_name = yandex_mdb_mysql_database.netology-db.name
    roles         = var.mysql_user_roles
  }
}