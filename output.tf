output "identityserverpassword" {
    value = module.create_sql_servers.identityserverpassword
    sensitive = true
}

# output "identityserversecondarypassword" {
#     value = module.create_sql_servers.identityserversecondarypassword
#     sensitive = true
# }

output "tenancymanagementpassword" {
    value = module.create_sql_servers.tenancymanagementpassword
    sensitive = true
}

# output "tenancymanagementsecondarypassword" {
#     value = module.create_sql_servers.tenancymanagementsecondarypassword
#     sensitive = true
# }

output "reportsserverpassword" {
    value = module.create_sql_servers.reportsserverpassword
    sensitive = true
}

# output "reportsserversecondarypassword" {
#     value = module.create_sql_servers.reportsserversecondarypassword
#     sensitive = true
# }

output "policyserverpassword" {
    value = module.create_sql_servers.policyserverpassword
    sensitive = true
}

# output "policyserversecondarypassword" {
#     value = module.create_sql_servers.policyserversecondarypassword
#     sensitive = true
# }
