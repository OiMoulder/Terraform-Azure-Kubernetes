variable "tags" {
  description = "Azure Resource Tags"
}

variable "client_name" {
  description = "Client Name"
}

variable "is_production" {
  type        = string
  description = "If the deployment is production or not"
}

variable "resource_group_name" {
  description = "Resource Group name"
}

variable "primary_location" {
  type        = string
  description = "Resources location in Azure"
}

variable "primary_location_to_azure_region" {
  description = "The name of the environment to use for the application"
  type        = map(any)
  default = {
    "uks" = "uksouth"
    "ukw" = "UK West"
    "weu" = "West Europe"
    "usw" = "westus"
    "use" = "eastus"
    "ue2" = "eastus2"
    "unc" = "northcentralus"
    "uw2" = "westus2"
    "uss" = "southcentralus"

    "usc" = "centralus"
    "bzs" = "brazilsouth"
    "cdc" = "canadacentral"
    "cde" = "canadaeast"
    "uwc" = "westcentralus"

    "eas" = "eastasia"
    "sea" = "southeastasia"
    "jpe" = "japaneast"
    "jpw" = "japanwest"

    "aue" = "australiaeast"
    "ase" = "australiasoutheast"
    "ace" = "australiacentral"
    "ac2" = "australiacentral2"

    "krs" = "koreasouth"
    "krc" = "koreacentral"
    "cne" = "chinaeast"
    "cnn" = "chinanorth"
    "ce2" = "chinaeast2"
    "cn2" = "chinanorth2"

    "san" = "southafricanorth"
    "saw" = "southafricawest"
    "uan" = "uaenorth"
    "uac" = "uaecentral"

    "frc" = "francecentral"
    "frs" = "francesouth"
    "gce" = "germanycentral"
    "gne" = "germanynortheast"

    "neu" = "northeurope"
  }
}

locals {
  azure_region = lookup(var.primary_location_to_azure_region, var.primary_location, "UK South")
}