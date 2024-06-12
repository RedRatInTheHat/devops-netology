# yandex provider
service_account_file_path = "~/.admin_authorized_key.json"

# service account variables
service_account_name            = "tfstate-lord"
service_account_storage_role    = "storage.editor"
service_account_ydb_role        = "ydb.editor"
member_type                     = "serviceAccount"
sa-static-key-description       = "Static access key for object storage and YDB."

# random string variables
random_string_length    = 3
has_upper               = false
has_lower               = true
has_numeric             = true
has_special             = false


# bucket variables
backet_base_name    = "terraformer"
bucket_max_size     = 1073741824 # 1Gb
anonymous_access    = {
    read        = false
    list        = false
    config_read = false
}

# database variables
database_name           = "terraform-db"
provisioned_rcu_limit   = 10
storage_size_limit      = 1

# lock_table_name = "tf_locks"
# billing_mode    = "PAY_PER_REQUEST"
# lock_column_name = "LockID"
# lock_column_type = "S"