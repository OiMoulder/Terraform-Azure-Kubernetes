output "identityserverpassword" {
    value = azurerm_mssql_server.identityserver.administrator_login_password
}

output "identityserversecondarypassword" {
    value = azurerm_mssql_server.identityserver_secondary.administrator_login_password
}

output "tenancymanagementpassword" {
    value = azurerm_mssql_server.TenancyManagement.administrator_login_password
}

output "tenancymanagementsecondarypassword" {
    value = azurerm_mssql_server.TenancyManagement_secondary.administrator_login_password
}

output "reportsserverpassword" {
    value = azurerm_mssql_server.reports.administrator_login_password
}

output "reportsserversecondarypassword" {
    value = azurerm_mssql_server.reports_secondary.administrator_login_password
}

output "policyserverpassword" {
    value = azurerm_mssql_server.policy_server.administrator_login_password
}

output "policyserversecondarypassword" {
    value = azurerm_mssql_server.policy_server_secondary.administrator_login_password
}