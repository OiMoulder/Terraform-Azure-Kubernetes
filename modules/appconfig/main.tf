resource "azurerm_app_configuration" "app_config" {
  name                = format("appcfg-%s-%s", var.primary_location, var.client_name)
  resource_group_name = var.resource_group_name
  location            = local.azure_region
  sku                 = "standard"
}
