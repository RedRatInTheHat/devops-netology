resource "yandex_ydb_database_serverless" "terraform_ydb" {
  name                = var.database_name

  serverless_database {
    provisioned_rcu_limit       = var.provisioned_rcu_limit
    storage_size_limit          = var.storage_size_limit
  }
}

# resource "aws_dynamodb_table" "lock_table" {
#   name         = var.lock_table_name
#   billing_mode = var.billing_mode

#   hash_key  = var.lock_column_name

#   attribute {
#     name = var.lock_column_name
#     type = var.lock_column_type
#   }
# }