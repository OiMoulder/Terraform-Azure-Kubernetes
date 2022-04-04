resource "azurerm_resource_group" "resource_group" {
  name     = format("rgp-%s-%s-main", var.primary_location, var.client_name)
  location = local.azure_region
}

provider "azurerm" {
  features {}

  subscription_id = var.dns_subscription
  alias = "moulder"
}

data "azurerm_resource_group" "dns_resource_group" {
  name = "rgp-weu-moulder-nonprod-dns"
  provider = azurerm.moulder
}