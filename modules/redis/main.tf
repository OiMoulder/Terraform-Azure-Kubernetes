resource "azurerm_redis_cache" "redis" {
  count               = var.deploy_redis ? 1 : 0
  name                = format("redis-%s-%s", var.primary_location, var.client_name)
  location            = local.azure_region
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Standard"
  minimum_tls_version = "1.2"

  patch_schedule {
    day_of_week    = "tuesday"
    start_hour_utc = 21
  }

  tags = var.tags
}
