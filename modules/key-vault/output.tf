output "key_vault_name" {
  value = azurerm_key_vault.keyvault.name
}

output "akv_id" {
  value = azurerm_key_vault.keyvault.id
}

output "akv_uri" {
  value = azurerm_key_vault.keyvault.vault_uri
}