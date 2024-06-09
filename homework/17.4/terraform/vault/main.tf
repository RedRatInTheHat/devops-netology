terraform {
  required_version = ">=1.5"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">=20"
    }
  }
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "kzY>i|)*t.'R4}'c)T_{"
}