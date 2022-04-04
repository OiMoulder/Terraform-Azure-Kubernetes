variable "client_name" {
  description = "Client Name"
}

variable "tags" {
  description = "Azure Resource Tags"
}

variable "primary_location" {
  description = "Short version of primary location"
}

variable "secondary_location" {
  description = "Short version of secondary location"
}

variable "location_1" {
  description = "Primary location of resources"
}

variable "location_2" {
  description = "Secondary location of resources"
}

variable "nodepool_vm_size_1" {
  description = "Tier of VM for the AKS Cluster Nodes"
}

variable "nodepool_vm_size_2" {
  description = "Tier of VM for the AKS Cluster Nodes"
}

variable "node_minimum_count" {
  description = "Minimum amount of AKS Cluster Nodes"
}

variable "node_maximum_count" {
  description = "Maximum amount of AKS Cluster Nodes"
}

variable "is_production" {
  description = ""
  default = false
}

variable "is_premium" {
  description = ""
  default = false
}

variable "deploy_redis" {
  description = ""
  default = false
}

variable "subscription_id" {
  description = ""
}

variable "dns_subscription" {
  description = ""
}

variable "parent_zone" {
  description = "Domain parent zone"
}

variable "dns_resource_group_name" {
  description = "Resource Group containing the Domain parent zone"
}

variable "location_short_to_azure_region" {
  description = "The name of the environment to use for the application"
  type        = map(any)
  default = {
    "uks" = "UK South"
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
    "ukw" = "ukwest"
  }
}