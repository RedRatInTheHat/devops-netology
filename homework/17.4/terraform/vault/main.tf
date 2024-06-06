terraform {
  required_version = ">=1.5"
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "education"
}