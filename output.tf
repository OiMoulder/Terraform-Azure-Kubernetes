output "sqlserverpassword" {
    value = module.create_sql_servers.sqlserverpassword
    sensitive = true
}

output "sqlserversecondarypassword" {
    value = module.create_sql_servers.sqlserversecondarypassword
    sensitive = true
}