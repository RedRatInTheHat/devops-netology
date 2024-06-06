output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data) 
}

output "updated_vault" {
  value = nonsensitive(data.vault_generic_secret.updated_vault.data) 
}