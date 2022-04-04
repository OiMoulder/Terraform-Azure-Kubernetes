resource "azurerm_public_ip_prefix" "ip_prefix" {
  name                = format("prefix-%s-%s", var.primary_location, var.client_name)
  location            = local.azure_region
  resource_group_name = var.resource_group_name
  prefix_length       = 29

  tags = var.tags
}

# Blue

resource "azurerm_public_ip" "blue_inpost" {
  name                = format("pubip-%s-inpost-%s-blue", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  location            = local.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = azurerm_public_ip_prefix.ip_prefix.id

  tags = var.tags
}

resource "azurerm_public_ip" "blue_ingress" {
  name                = format("pubip-%s-ingress-%s-blue", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  location            = local.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = azurerm_public_ip_prefix.ip_prefix.id

  tags = var.tags
}

resource "azurerm_public_ip" "blue_egress" {
  name                = format("pubip-%s-egress-%s-blue", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  location            = local.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = azurerm_public_ip_prefix.ip_prefix.id

  tags = var.tags
}


resource "azurerm_public_ip" "blue_testing" {
  name                = format("pubip-%s-testing-%s-blue", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  location            = local.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = azurerm_public_ip_prefix.ip_prefix.id

  tags = var.tags
}

# Green

resource "azurerm_public_ip" "green_inpost" {
  name                = format("pubip-%s-inpost-%s-green", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  location            = local.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = azurerm_public_ip_prefix.ip_prefix.id

  tags = var.tags
}

resource "azurerm_public_ip" "green_ingress" {
  name                = format("pubip-%s-ingress-%s-green", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  location            = local.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = azurerm_public_ip_prefix.ip_prefix.id

  tags = var.tags
}

resource "azurerm_public_ip" "green_egress" {
  name                = format("pubip-%s-egress-%s-green", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  location            = local.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = azurerm_public_ip_prefix.ip_prefix.id

  tags = var.tags
}

resource "azurerm_public_ip" "green_testing" {
  name                = format("pubip-%s-testing-%s-green", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  location            = local.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  public_ip_prefix_id = azurerm_public_ip_prefix.ip_prefix.id

  tags = var.tags
}