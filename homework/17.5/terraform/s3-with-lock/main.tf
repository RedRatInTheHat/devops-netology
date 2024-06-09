terraform {
  required_version = ">= 1.3.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "> 0.9"
    }

    random = {
      source  = "hashicorp/random"
      version = "> 3.5"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "yandex" {
  service_account_key_file  = file(var.service_account_file_path)
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
  zone                      = var.default_zone
}

# provider "aws" {
#   region = var.default_region
#   endpoints {
#     dynamodb = yandex_ydb_database_serverless.terraform_ydb.document_api_endpoint
#   }

#   skip_credentials_validation = var.aws_mock.skip_all
#   skip_metadata_api_check     = var.aws_mock.skip_all
#   skip_region_validation      = var.aws_mock.skip_all
#   skip_requesting_account_id  = var.aws_mock.skip_all
#   access_key                  = var.aws_mock.access_key
#   secret_key                  = var.aws_mock.secret_key
# }