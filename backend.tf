terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform.moulder"
    storage_account_name = "terraformmoulder"
    container_name       = "tfstatemoulder"
    key                  = "production"
  }
}
