variable "client_name" {
  type    = string
  default = ""
}

variable "tags" {
  type = map(string)
}

variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "parent_zone" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_id" {
  type = string
}

variable "is_production" {
  type    = bool
  default = false
}

variable "admin_user" {
  type = string
  default = "sqladmin"
}

variable "sql-fw-rules" {
  description = "provide a list of ip's to allow ext access to the sql server"
  type = list(object({
    name     = string
    start_ip = string
    end_ip   = string
  }))
  default = [{
    name     = "allowazure",
    start_ip = "0.0.0.0",
    end_ip   = "0.0.0.0"
    },
    {
      name     = "PERIM_VPN_UK_1",
      start_ip = "212.59.65.142",
      end_ip   = "212.59.65.142"
    },
    {
      name     = "PERIM_VPN_UK_2",
      start_ip = "212.59.65.150",
      end_ip   = "212.59.65.150"
    },
    {
      name     = "PERIM_VPN_EU_1",
      start_ip = "172.104.150.88",
      end_ip   = "172.104.150.88"
    },
    {
      name     = "PERIM_VPN_US_1",
      start_ip = "131.226.32.111",
      end_ip   = "131.226.32.111"
  }]
}

variable "primary_location" {
  type        = string
  description = "Resources location in Azure"
}

variable "secondary_location" {
  type    = string
  default = ""
}

variable "location_short" {
  type    = string
  default = ""
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

variable "secondary_location_to_azure_region" {
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
  azure_region               = lookup(var.primary_location_to_azure_region, var.primary_location, "UK South")
  azure_sql_failover_region  = lookup(var.secondary_location_to_azure_region, var.secondary_location, "West Europe")
  child_domain               = var.client_name
  full_domain                = "${local.child_domain}.${var.parent_zone}"
  environments               = var.is_production ? ["blue", "green"] : ["blue"]
}