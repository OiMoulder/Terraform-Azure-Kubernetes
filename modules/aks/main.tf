data "azurerm_kubernetes_service_versions" "current" {
  location       = local.azure_region
  version_prefix = var.kube_version_prefix
}

resource "azurerm_kubernetes_cluster" "aks1" {
  name                    = format("%s-%s-blue", var.primary_location, var.client_name)
  location                = local.azure_region
  kubernetes_version      = data.azurerm_kubernetes_service_versions.current.latest_version
  resource_group_name     = var.resource_group_name
  dns_prefix              = format("%s-%s-blue", local.azure_region, var.client_name)
  private_cluster_enabled = false

  default_node_pool {
    name                = "default"
    vm_size             = var.nodepool_vm_size_1
    availability_zones  = ["1", "2", "3"]

    enable_auto_scaling = true
    min_count           = var.node_minimum_count
    max_count           = var.node_maximum_count
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }
  
  tags = var.tags
}



resource "azurerm_kubernetes_cluster" "aks2" {
  name                    = format("%s-%s-green", var.primary_location, var.client_name)
  location                = local.azure_region
  kubernetes_version      = data.azurerm_kubernetes_service_versions.current.latest_version
  resource_group_name     = var.resource_group_name
  dns_prefix              = format("%s-%s-green", local.azure_region, var.client_name)
  private_cluster_enabled = false

  default_node_pool {
    name                = "default"
    vm_size             = var.nodepool_vm_size_2
    availability_zones  = ["1", "2", "3"]

    enable_auto_scaling = true
    min_count           = var.node_minimum_count
    max_count           = var.node_maximum_count
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }
  
  tags = var.tags
}
