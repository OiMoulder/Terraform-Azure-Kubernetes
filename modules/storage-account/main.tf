resource "azurerm_storage_account" "storage_account" {
  name                     = format("sa%s%s", var.primary_location, var.client_name)
  resource_group_name      = var.resource_group_name
  location                 = local.azure_region
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "RAGRS"
  
  tags = var.tags
}

resource "azurerm_storage_table" "example-cache" {
  name                 = "exampleCache"
  storage_account_name = azurerm_storage_account.storage_account.name
}