resource "yandex_iam_service_account" "sa" {
  name = var.service_account_name
}

resource "yandex_resourcemanager_folder_iam_member" "storage-member" {
  folder_id = var.folder_id
  role      = var.service_account_storage_role
  member    = local.sa_member
}

resource "yandex_resourcemanager_folder_iam_member" "ydb-member" {
  folder_id = var.folder_id
  role      = var.service_account_ydb_role
  member    = local.sa_member
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = var.sa-static-key-description
}