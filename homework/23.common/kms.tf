# resource "yandex_kms_symmetric_key" "kms-key" {
#   name              = var.kms_key_name
#   description       = var.kms_key_description
#   default_algorithm = var.kms_key_algorithm
#   rotation_period   = var.kms_key_rotation_period
# }