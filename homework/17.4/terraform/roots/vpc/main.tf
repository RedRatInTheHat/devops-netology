terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">=0.119.0"
    }
  }
  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket = "terraformer-ux3"
    region = "ru-central1"
    key = "terraform-vpc.tfstate"

    skip_region_validation = true
    skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g1dt98fnh20q8l0229/etneha6a7eqms28rl4li"
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