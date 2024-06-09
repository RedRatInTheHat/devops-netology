terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">=0.119.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">=0"
    }
  }
  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket = "netology-bucket-ryoxybgu"
    region = "ru-central1"
    key = "terraform.tfstate"

    skip_region_validation = true
    skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g1dt98fnh20q8l0229/etnq3r3aoreujp9u77aq"
    dynamodb_table    = "tf-locks"
  }
  required_version = ">=0.13"
}

provider "yandex" {
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
  zone                      = var.default_zone
  service_account_key_file  = file("~/.authorized_key.json")
}