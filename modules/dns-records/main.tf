provider "azurerm" {
  features {}

  subscription_id = var.dns_subscription
  alias = "moulder"
}

resource "azurerm_dns_ns_record" "child_zone_link" {
  provider            = azurerm.moulder
  name                = var.client_name
  zone_name           = var.parent_zone
  resource_group_name = var.dns_resource_group_name
  ttl                 = 30

  records = azurerm_dns_zone.environment_general.name_servers

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
    azurerm_dns_zone.environment_general
  ]

  tags                = var.tags
}

resource "azurerm_dns_zone" "environment_general" {
  name                  = format("%s.%s", var.client_name, var.parent_zone)
  resource_group_name   = var.resource_group_name
}

## DNS MX Record

resource "azurerm_dns_mx_record" "region_1" {
  name                = "@"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 30
  record {
    preference = 0
    exchange   = format("smtp.%s.%s", var.client_name, var.parent_zone)
  }
  
  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

## DNS CNAME Records

resource "azurerm_dns_cname_record" "smtp_1" {
  name                = "smtp"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  target_resource_id  = var.traffic_manager_inpost_id

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

resource "azurerm_dns_cname_record" "portal_1" {
  name                = "portal"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  target_resource_id  = var.traffic_manager_ingress_id

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

## DNS A Records

# Blue

resource "azurerm_dns_a_record" "blue" {
  name                = "blue"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  records             = [var.blue_ingress_ip_address]

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

resource "azurerm_dns_a_record" "smtp_blue" {
  name                = "smtp.blue"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  records             = [var.blue_inpost_ip_address]

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

resource "azurerm_dns_a_record" "egress_blue" {
  name                = "egress.blue"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  records             = [var.blue_egress_ip_address]

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

resource "azurerm_dns_a_record" "testing_blue" {
  name                = "testing.blue"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  records             = [var.blue_testing_ip_address]

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

# Green

resource "azurerm_dns_a_record" "green" {
  count               = var.is_production ? 1 : 0

  name                = "green"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  records             = [var.green_ingress_ip_address]

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

resource "azurerm_dns_a_record" "smtp_green" {
  count               = var.is_production ? 1 : 0

  name                = "smtp.green"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  records             = [var.green_inpost_ip_address]

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

resource "azurerm_dns_a_record" "egress_green" {
  count               = var.is_production ? 1 : 0

  name                = "egress.green"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  records             = [var.green_egress_ip_address]

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}

resource "azurerm_dns_a_record" "testing_green" {
  count               = var.is_production ? 1 : 0

  name                = "testing.green"
  zone_name           = azurerm_dns_zone.environment_general.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  records             = [var.green_testing_ip_address]

  depends_on = [
    var.blue_egress_ip_address,
    var.blue_ingress_ip_address,
    var.blue_inpost_ip_address,
    var.blue_testing_ip_address,
    var.green_egress_ip_address,
    var.green_ingress_ip_address,
    var.green_inpost_ip_address,
    var.green_testing_ip_address,
    var.traffic_manager_ingress_id,
    var.traffic_manager_inpost_id,
  ]
}