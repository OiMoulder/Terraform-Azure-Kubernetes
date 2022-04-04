resource "azurerm_traffic_manager_profile" "ingress_profile" {
  name                   = format("trffmgr-%s-ingress-%s", var.primary_location, var.client_name)
  resource_group_name    = var.resource_group_name
  traffic_routing_method = "Weighted"
  profile_status         = "Enabled"

  dns_config {
    relative_name = format("trffmgr-%s-ingress-%s", var.primary_location, var.client_name)
    ttl           = 30
  }

  monitor_config {
    protocol                    = "HTTPS"
    port                        = 443
    expected_status_code_ranges = ["200-399"]
    path                        = "/"
  }

  tags = var.tags
}

resource "azurerm_traffic_manager_endpoint" "ingress_endpoint_blue" {
  name                = format("tmep-%s-ingress-%s-blue", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.ingress_profile.name
  target              = format("blue.%s.%s", var.client_name, var.parent_zone)
  type                = "ExternalEndpoints"
}

resource "azurerm_traffic_manager_endpoint" "ingress_endpoint_green" {
  name                = format("tmep-%s-ingress-%s-green", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.ingress_profile.name
  target              = format("green.%s.%s", var.client_name, var.parent_zone)
  type                = "ExternalEndpoints"
}

resource "azurerm_traffic_manager_profile" "inpost_profile" {
  name                   = format("trffmgr-%s-inpost-%s", var.primary_location, var.client_name)
  resource_group_name    = var.resource_group_name
  traffic_routing_method = "Weighted"
  profile_status         = "Enabled"

  dns_config {
    relative_name = format("trffmgr-%s-inpost-%s", var.primary_location, var.client_name)
    ttl           = 30
  }

  monitor_config {
    protocol = "TCP"
    port     = 25
  }

  tags = var.tags
}

resource "azurerm_traffic_manager_endpoint" "inpost_endpoint_blue" {
  name                = format("tmep-%s-inpost-%s-blue", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.inpost_profile.name
  target              = format("smtp.blue.%s.%s", var.client_name, var.parent_zone)
  type                = "ExternalEndpoints"
}

resource "azurerm_traffic_manager_endpoint" "inpost_endpoint_green" {
  name                = format("tmep-%s-inpost-%s-green", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.inpost_profile.name
  target              = format("smtp.green.%s.%s", var.client_name, var.parent_zone)
  type                = "ExternalEndpoints"
}
