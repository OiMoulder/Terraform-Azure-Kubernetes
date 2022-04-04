output "sqlserverpassword" {
    value = azurerm_mssql_server.sqlserver.administrator_login_password
}

output "sqlserversecondarypassword" {
    value = azurerm_mssql_server.sqlserver_secondary.administrator_login_password
}