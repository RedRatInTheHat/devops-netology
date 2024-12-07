# resource "yandex_storage_bucket" "image-bucket" {
#   access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#   secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#   bucket                = var.bucket_name
#   max_size              = var.bucket_max_size

#   anonymous_access_flags {
#     read        = var.is_readable
#   }
# }

# resource "yandex_storage_bucket" "kms-bucket" {
#   access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#   secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#   bucket                = var.kms_bucket_name
#   max_size              = var.bucket_max_size

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         kms_master_key_id = yandex_kms_symmetric_key.kms-key.id
#         sse_algorithm     = var.sse_algorithm
#       }
#     }
#   }
# }

# resource "yandex_storage_object" "image" {
#   access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#   secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#   bucket     = var.bucket_name
#   key        = var.bucket_image_key
#   source     = var.bucket_image_source_path
# }

# resource "yandex_storage_object" "kms-image" {
#   access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#   secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#   bucket     = var.kms_bucket_name
#   key        = var.bucket_image_key
#   source     = var.bucket_image_source_path
# }