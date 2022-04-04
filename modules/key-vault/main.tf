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

resource "azurerm_key_vault_secret" "identityserver" {
  name         = format("sql-cas-password")
  value        = var.identityserverpassword
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
    create_before_destroy = true
  }

}

# resource "azurerm_key_vault_secret" "identityserversecondary" {
#   name         = format("sql-cas-password")
#   value        = var.identityserversecondarypassword
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

resource "azurerm_key_vault_secret" "tenancymanagement" {
  name         = format("sql-tenman-password")
  value        = var.tenancymanagementpassword
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
    create_before_destroy = true
  }

}

# resource "azurerm_key_vault_secret" "tenancymanagementsecondary" {
#   name         = format("sql-tenman-password")
#   value        = var.tenancymanagementsecondarypassword
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

resource "azurerm_key_vault_secret" "reportsserver" {
  name         = format("sql-reports-password")
  value        = var.reportsserverpassword
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
    create_before_destroy = true
  }

}

# resource "azurerm_key_vault_secret" "reportsserversecondary" {
#   name         = format("sql-tenman-password")
#   value        = var.reportsserversecondarypassword
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }

resource "azurerm_key_vault_secret" "policyserverpassword" {
  name         = format("sql-policy-password")
  value        = var.policyserverpassword
  key_vault_id = azurerm_key_vault.keyvault.id

  lifecycle {
    create_before_destroy = true
  }

}

# resource "azurerm_key_vault_secret" "policyserversecondary" {
#   name         = format("sql-policy-password")
#   value        = var.policyserversecondarypassword
#   key_vault_id = azurerm_key_vault.keyvault.id

#   lifecycle {
#     create_before_destroy = true
#   }

# }