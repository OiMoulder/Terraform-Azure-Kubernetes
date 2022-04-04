variable "client_name" {
  description = "Client Name"
}

variable "tags" {
  description = "Azure Resource Tags"
}

variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "cluster_name_1" {
  type        = string
  description = "AKS name in Azure"
}

variable "cluster_name_2" {
  type        = string
  description = "AKS name in Azure"
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "azure_object_id" {
  type        = string
  description = "Azure Object ID"
}

variable "servicebus_namespace_1" {
  type        = string
  description = "Service Bus Namespace"
}

variable "servicebus_namespace_2" {
  description = "Service Bus Namespace"
}

# variable "blue_egress_ip_address" {
#   description = ""
# }

# variable "blue_ingress_ip_address" {
#   description = ""
# }

# variable "blue_inpost_ip_address" {
#   description = ""
# }

# variable "blue_testing_ip_address" {
#   description = ""
# }

# variable "green_egress_ip_address" {
#   description = ""
# }

# variable "green_ingress_ip_address" {
#   description = ""
# }

# variable "green_inpost_ip_address" {
#   description = ""
# }

# variable "green_testing_ip_address" {
#   description = ""
# }

variable "identityserverpassword" {
  description = ""
}

# variable "identityserversecondarypassword" {
#   description = ""
# }

variable "tenancymanagementpassword" {
  description = ""
}

# variable "tenancymanagementsecondarypassword" {
#   description = ""
# }

variable "reportsserverpassword" {
  description = ""
}

# variable "reportsserversecondarypassword" {
#   description = ""
# }

variable "policyserverpassword" {
  description = ""
}

# variable "policyserversecondarypassword" {
#   description = ""
# }

variable "is_production" {
  type        = string
  description = "If the deployment is production or not"
}

variable "primary_location" {
  type        = string
  description = "Resources location in Azure"
}

variable "secondary_location" {
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