resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "s3" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=5d273da"

  bucket_name = "netology-bucket-${random_string.unique_id.result}"
  max_size    = 1073741824
}