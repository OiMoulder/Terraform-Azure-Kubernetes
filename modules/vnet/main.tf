resource "azurerm_network_security_group" "k8ssecuritygroup" {
  name                = format("nsg-%s-k8s-%s", var.primary_location, var.client_name)
  location            = local.azure_region
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_security_rule" "vpn-nsg-rule" {
  name                        = format("moulder-VPN-%s", azurerm_network_security_group.k8ssecuritygroup.name)
  priority                    = 900
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["25", "443", "465", "587", "2525"]
  source_address_prefixes     = ["0.0.0.0"]
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.k8ssecuritygroup.name
}

resource "azurerm_network_security_rule" "open-nsg-rule" {
  name                        = format("open-smtp-%s", azurerm_network_security_group.k8ssecuritygroup.name)
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443"]
  source_address_prefixes     = ["0.0.0.0/0"]
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.k8ssecuritygroup.name
}

resource "azurerm_network_security_rule" "trafficmanager-nsg-rule" {
  name                        = format("AllowAzureTrafficmanagerin-%s", azurerm_network_security_group.k8ssecuritygroup.name)
  priority                    = 3900
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureTrafficManager"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.k8ssecuritygroup.name
}

resource "azurerm_virtual_network" "k8svnet" {
  for_each            = { for environment in local.environments : environment => environment }
  name                = "vnet-${var.primary_location}-moulder-${var.client_name}-${each.key}"
  location            = local.azure_region
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/12"]

  tags = merge(var.tags, {})
}

resource "azurerm_subnet" "k8ssubnet" {
  for_each             = { for environment in local.environments : environment => environment }
  name                 = "vnet-${var.primary_location}-moulder-${var.client_name}-cluster-${each.key}"
  address_prefixes     = ["10.0.0.0/16"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.k8svnet[each.key].name
}

resource "azurerm_subnet_network_security_group_association" "k8snsgassociation" {
  for_each                  = { for environment in local.environments : environment => environment }
  subnet_id                 = azurerm_subnet.k8ssubnet[each.key].id
  network_security_group_id = azurerm_network_security_group.k8ssecuritygroup.id
}

/*
moulder-vnet-nonprod:
  azure:
    location: westeurope
    environment: public
    primary_location: weu
    area: nonprod
*/
