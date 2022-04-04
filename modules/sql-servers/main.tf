resource "azurerm_storage_account" "storage_account" {
  name                     = format("sqlauditsa%s%s", var.primary_location, var.client_name)
  resource_group_name      = var.resource_group_name
  location                 = local.azure_region
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "RAGRS"

  tags = var.tags
}

resource "random_password" "password" {
  count            = 4
  length           = 24
  special          = true
  min_lower        = 6
  min_upper        = 6
  min_numeric      = 6
  min_special      = 6
}

##################################

# SQL Server

resource "azurerm_mssql_server" "sqlserver" {
  name                         = format("sql-%s-%s", var.primary_location, var.client_name)
  resource_group_name          = var.resource_group_name
  location                     = local.azure_region
  version                      = "12.0"
  administrator_login          = var.admin_user
  administrator_login_password = random_password.password[0].result

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage_account.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage_account.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}

resource "azurerm_mssql_server" "sqlserver_secondary" {
  name                         = format("sql-%s-%s", var.secondary_location, var.client_name)
  resource_group_name          = var.resource_group_name
  location                     = local.azure_sql_failover_region
  version                      = "12.0"
  administrator_login          = var.admin_user
  administrator_login_password = random_password.password[0].result

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage_account.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage_account.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}

##################################

# Firewall Rules

resource "azurerm_mssql_firewall_rule" "sqlserverazuredevops" {
  name                = "SQLServerAzureDevops"
  server_id           = azurerm_mssql_server.sqlserver.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "sqlserverazuredevops_secondary" {
  name                = "SqlServerAzureDevopsSecondary"
  server_id           = azurerm_mssql_server.sqlserver_secondary.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

##################################

# Failover Groups

resource "azurerm_mssql_failover_group" "sqlserver_failovergroup" {
  name                = format("sqlserver-failover-group-%s", var.client_name)
  server_id           = azurerm_mssql_server.sqlserver.id
  databases           = [azurerm_mssql_database.identitycoredb.id, azurerm_mssql_database.identityserverdb.id]
  partner_server {
    id = azurerm_mssql_server.sqlserver_secondary.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }
}

##################################

# Databases

resource "azurerm_mssql_database" "identitycoredb" {
  name                = "identity_core"
  server_id           = azurerm_mssql_server.sqlserver.id
  sku_name            = "S0"
  max_size_gb         = 10

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage_account.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage_account.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "identityserverdb" {
  name                = "identity_server"
  server_id           = azurerm_mssql_server.sqlserver.id
  sku_name            = "S0"
  max_size_gb         = 10

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage_account.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage_account.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "tenancymanagementdb" {
  name                = "TenancyManagement"
  server_id           = azurerm_mssql_server.sqlserver.id
  sku_name            = "S0"
  max_size_gb         = 10

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage_account.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage_account.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "reportsdb" {
  name                = "TransactionReports"
  server_id           = azurerm_mssql_server.sqlserver.id
  sku_name            = "S0"
  max_size_gb         = 10

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage_account.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage_account.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "policy_server_db" {
  name                = "PolicyServer"
  server_id           = azurerm_mssql_server.sqlserver.id
  sku_name            = "S0"
  max_size_gb         = 10

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage_account.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage_account.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}