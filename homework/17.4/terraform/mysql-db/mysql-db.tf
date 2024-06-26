resource "yandex_mdb_mysql_database" "db" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "db_user" {
  cluster_id = var.cluster_id
  name       = var.user_name
  password   = var.password
  permission {
    database_name = yandex_mdb_mysql_database.db.name
    roles         = var.roles
  }
}