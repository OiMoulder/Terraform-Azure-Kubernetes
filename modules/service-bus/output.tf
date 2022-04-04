output "service_bus_id_1" {
    value = azurerm_servicebus_namespace.service_bus_namespace_blue.id
}

output "service_bus_id_2" {
    value = azurerm_servicebus_namespace.service_bus_namespace_green.id
}

output "service_bus_name_1" {
    value = azurerm_servicebus_namespace.service_bus_namespace_blue.name
}

output "service_bus_name_2" {
    value = azurerm_servicebus_namespace.service_bus_namespace_green.name
}