output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}

output "resource_group_id" {
  value = azurerm_resource_group.resource_group.id
}

output "dns_resource_group_name" {
  value = data.azurerm_resource_group.dns_resource_group.name
}

output "dns_resource_group_id" {
  value = data.azurerm_resource_group.dns_resource_group.id
}