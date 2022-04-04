resource "azurerm_key_vault" "keyvault" {
  name                            = format("akv-%s", var.client_name)
  location                        = local.azure_region
  resource_group_name             = var.resource_group_name
  enabled_for_disk_encryption     = true
  tenant_id                       = var.azure_tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  enabled_for_deployment          = true

  sku_name = "standard"

  access_policy {
    tenant_id = var.azure_tenant_id
    object_id = var.azure_object_id

    certificate_permissions = [
      "Get",
      "List",
      "Create",
      "Update",
      "Import",
    ]

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Update",
      "Import",
    ]

    secret_permissions = [
      "Get",
      "Backup",
      "Delete",
      "list",
      "purge",
      "recover",
      "restore",
      "set",
    ]

    storage_permissions = [
      "Get",
      "GetSAS",
      "List",
      "ListSAS",
      "Set",
      "SetSAS",
      "Update",
    ]
  }

  tags = var.tags
}

# resource "azurerm_key_vault_secret" "blue_egress" {
#   name         = format("%s-egress-public-ip", var.cluster_name_1)
#   value        = var.blue_egress_ip_address
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

# resource "azurerm_key_vault_secret" "blue_ingress" {
#   name         = format("%s-ingress-public-ip", var.cluster_name_1)
#   value        = var.blue_ingress_ip_address
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

# resource "azurerm_key_vault_secret" "blue_inpost" {
#   name         = format("%s-inpost-public-ip", var.cluster_name_1)
#   value        = var.blue_inpost_ip_address
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

# resource "azurerm_key_vault_secret" "blue_testing" {
#   name         = format("%s-testing-public-ip", var.cluster_name_1)
#   value        = var.blue_testing_ip_address
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

# resource "azurerm_key_vault_secret" "green_egress" {
#   name         = format("%s-egress-public-ip", var.cluster_name_1)
#   value        = var.green_egress_ip_address
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

# resource "azurerm_key_vault_secret" "green_ingress" {
#   name         = format("%s-ingress-public-ip", var.cluster_name_1)
#   value        = var.green_ingress_ip_address
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

# resource "azurerm_key_vault_secret" "green_inpost" {
#   name         = format("%s-inpost-public-ip", var.cluster_name_1)
#   value        = var.green_inpost_ip_address
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

# resource "azurerm_key_vault_secret" "green_testing" {
#   name         = format("%s-testing-public-ip", var.cluster_name_1)
#   value        = var.green_testing_ip_address
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

resource "azurerm_key_vault_secret" "sqlserver" {
  name         = format("sql-password")
  value        = var.sqlserverpassword
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_key_vault_secret" "sqlserversecondary" {
  name         = format("sql-secondary-password")
  value        = var.sqlserversecondarypassword
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
  create_before_destroy = true
  }
}