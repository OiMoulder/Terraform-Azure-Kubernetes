resource "azurerm_servicebus_namespace" "service_bus_namespace_blue" {
  name                = format("sb-%s-%s-blue", var.primary_location, var.client_name)
  location            = local.azure_region
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_servicebus_queue" "message-regeneration-blue" {
  resource_group_name                     = azurerm_servicebus_namespace.service_bus_namespace_blue.resource_group_name
  namespace_name                          = azurerm_servicebus_namespace.service_bus_namespace_blue.name
  name                                    = "MessageQueue"
  dead_lettering_on_message_expiration    = true
  max_size_in_megabytes                   = 1024
  max_delivery_count                      = 10
  lock_duration                           = "PT3M30S"
  requires_duplicate_detection            = true
  duplicate_detection_history_time_window = "P7D"

}

resource "azurerm_servicebus_queue_authorization_rule" "message-queue-write-blue" {
  name                = "Write"
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace_blue.name
  queue_name          = azurerm_servicebus_queue.message-queue-blue.name
  resource_group_name = azurerm_servicebus_namespace.service_bus_namespace_blue.resource_group_name

  listen = true
  send   = true
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "message-queue-read-blue" {
  name                = "Read"
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace_blue.name
  queue_name          = azurerm_servicebus_queue.message-queue-blue.name
  resource_group_name = azurerm_servicebus_namespace.service_bus_namespace_blue.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "message-queue-fullcontrol-blue" {
  name                = "FullControl"
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace_blue.name
  queue_name          = azurerm_servicebus_queue.message-queue-blue.name
  resource_group_name = azurerm_servicebus_namespace.service_bus_namespace_blue.resource_group_name

  listen = true
  send   = true
  manage = true
}

resource "azurerm_servicebus_namespace" "service_bus_namespace_green" {
  name                = format("sb-%s-%s-green", var.primary_location, var.client_name)
  location            = local.azure_region
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_servicebus_queue" "message-queue-green" {
  resource_group_name                     = azurerm_servicebus_namespace.service_bus_namespace_green.resource_group_name
  namespace_name                          = azurerm_servicebus_namespace.service_bus_namespace_green.name
  name                                    = "MessageQueue"
  dead_lettering_on_message_expiration    = true
  max_size_in_megabytes                   = 1024
  max_delivery_count                      = 10
  lock_duration                           = "PT3M30S"
  requires_duplicate_detection            = true
  duplicate_detection_history_time_window = "P7D"

}

resource "azurerm_servicebus_queue_authorization_rule" "message-queue-write-green" {
  name                = "Write"
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace_green.name
  queue_name          = azurerm_servicebus_queue.message-queue-green.name
  resource_group_name = azurerm_servicebus_namespace.service_bus_namespace_green.resource_group_name

  listen = true
  send   = true
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "message-queue-read-green" {
  name                = "Read"
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace_green.name
  queue_name          = azurerm_servicebus_queue.message-queue-green.name
  resource_group_name = azurerm_servicebus_namespace.service_bus_namespace_green.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "message-queue-fullcontrol-green" {
  name                = "FullControl"
  namespace_name      = azurerm_servicebus_namespace.service_bus_namespace_green.name
  queue_name          = azurerm_servicebus_queue.message-queue-green.name
  resource_group_name = azurerm_servicebus_namespace.service_bus_namespace_green.resource_group_name

  listen = true
  send   = true
  manage = true
}
