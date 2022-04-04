terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.98.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.18.0"
    }
    time = {
      source = "hashicorp/time"
      version = "0.7.2"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.2"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}

  subscription_id = var.dns_subscription
  alias = "moulder"
}

provider "azuread" {
  features {}

  subscription_id = var.subscription_id
}

provider "random" {
}