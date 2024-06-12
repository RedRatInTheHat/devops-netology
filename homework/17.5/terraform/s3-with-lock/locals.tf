locals {
    sa_member   = "${var.member_type}:${yandex_iam_service_account.sa.id}"
    bucket_name = "${var.backet_base_name}-${random_string.unique_id.result}"
}