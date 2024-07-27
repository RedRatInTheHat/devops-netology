terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">=0.119.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">=2.3.0"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
  zone                      = var.default_zone
  service_account_key_file  = file("~/.authorized_key.json")
}