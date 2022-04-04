variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "dns_resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "dns_subscription" {
  type        = string
  description = "DNS subscription"
}

variable "client_name" {
  type    = string
  default = ""
}

variable "tags" {
  type = map(string)
}

variable "secondary_location" {
  type        = string
  description = "Resources location in Azure"
}

variable "parent_zone" {
  type        = string
  description = "Full domain"
}

variable "blue_ingress_ip_address" {
  description = "Public IP output from the Public IP modules"
}

variable "blue_inpost_ip_address" {
  description = "Public IP output from the Public IP modules"
}

variable "blue_egress_ip_address" {
  description = "Public IP output from the Public IP modules"
}

variable "blue_testing_ip_address" {
  description = "Public IP output from the Public IP modules"
}

variable "green_ingress_ip_address" {
  description = "Public IP output from the Public IP modules"
}

variable "green_inpost_ip_address" {
  description = "Public IP output from the Public IP modules"
}

variable "green_egress_ip_address" {
  description = "Public IP output from the Public IP modules"
}

variable "green_testing_ip_address" {
  description = "Public IP output from the Public IP modules"
}

variable "is_production" {
  type        = string
  description = "If the deployment is production or not"
}

variable "traffic_manager_inpost_id" {
  type        = string
  description = "ID/Scope of the traffic manager"
}

variable "traffic_manager_ingress_id" {
  type        = string
  description = "ID/Scope of the traffic manager"
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