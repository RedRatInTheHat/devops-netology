output "cluster_id" {
  value       = yandex_mdb_mysql_cluster.db.id
  description = "ID of the created mysql cluster"
}
