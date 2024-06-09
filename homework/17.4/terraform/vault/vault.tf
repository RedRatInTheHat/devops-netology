data "vault_generic_secret" "vault_example" {
  path = var.secret_path
}

resource "vault_generic_secret" "netology_secret" {
  path = var.secret_path
  data_json = jsonencode(
    merge(
      data.vault_generic_secret.vault_example.data,
      {"hi doggy": "oh hi mark"}
      )
  )
}

data "vault_generic_secret" "updated_vault" {
  depends_on = [vault_generic_secret.netology_secret]
  path = var.secret_path
}