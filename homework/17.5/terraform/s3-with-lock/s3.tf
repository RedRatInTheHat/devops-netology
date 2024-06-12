resource "random_string" "unique_id" {
  length  = var.random_string_length
  upper   = var.has_upper
  lower   = var.has_lower
  numeric = var.has_numeric
  special = var.has_special
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "terrafor-bucket" {
  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

  bucket                = local.bucket_name
  max_size              = var.bucket_max_size

  anonymous_access_flags {
    read        = var.anonymous_access.read
    list        = var.anonymous_access.list
    config_read = var.anonymous_access.config_read
  }
}