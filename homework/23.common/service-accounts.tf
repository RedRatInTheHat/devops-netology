# Bucket

resource "yandex_iam_service_account" "sa" {
  name = var.service_account_name
}

resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
  folder_id = var.folder_id
  role      = var.sa_admin_role
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = var.static_key_description
}

# Instance Group

resource "yandex_iam_service_account" "editor-sa" {
  name        = var.editor_sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id  = var.folder_id
  role       = var.editor_role
  member     = "serviceAccount:${yandex_iam_service_account.editor-sa.id}"
  depends_on = [
    yandex_iam_service_account.editor-sa,
  ]
}