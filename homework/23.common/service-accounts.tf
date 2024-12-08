# # Bucket

# resource "yandex_iam_service_account" "sa" {
#   name = var.service_account_name
# }

# resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
#   folder_id = var.folder_id
#   role      = var.sa_admin_role
#   member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
# }

# resource "yandex_resourcemanager_folder_iam_member" "sa-kms" {
#   folder_id = var.folder_id
#   role      = var.kms_role
#   member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
# }

# resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
#   service_account_id = yandex_iam_service_account.sa.id
#   description        = var.static_key_description
# }

# # Instance Group

# resource "yandex_iam_service_account" "editor-sa" {
#   name        = var.editor_sa_name
# }

# resource "yandex_resourcemanager_folder_iam_member" "editor" {
#   folder_id  = var.folder_id
#   role       = var.editor_role
#   member     = "serviceAccount:${yandex_iam_service_account.editor-sa.id}"
#   depends_on = [
#     yandex_iam_service_account.editor-sa,
#   ]
# }

# Regional K8S

resource "yandex_iam_service_account" "regional-k8s-account" {
  name        = var.k8s_service_account_name
  description = var.k8s_service_account_description
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  folder_id   = var.folder_id
  role        = var.k8s_clusters_agent_role
  member      = "serviceAccount:${yandex_iam_service_account.regional-k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  folder_id = var.folder_id
  role      = var.vpc_public_admin_role
  member    = "serviceAccount:${yandex_iam_service_account.regional-k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  folder_id = var.folder_id
  role      = var.images_puller_role
  member    = "serviceAccount:${yandex_iam_service_account.regional-k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
  folder_id = var.folder_id
  role      = var.encrypter_decrypter_role
  member    = "serviceAccount:${yandex_iam_service_account.regional-k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.regional-k8s-account.id}"
}