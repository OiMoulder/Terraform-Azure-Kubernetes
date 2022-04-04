# Cluster Deployment Modules

module "azure_config" {
  source = "./modules/azure-config"
  
}

module "create_resource_group" {
  source = "./modules/resource-group"

  client_name                       = var.client_name
  primary_location                  = var.primary_location
}

module "app_config" {
  source = "./modules/appconfig"
  
  client_name                             = var.client_name
  tags                                    = var.tags
  resource_group_name                     = module.create_resource_group.resource_group_name
  primary_location                        = var.primary_location
}

module "create_k8s_clusters" {
  source        = "./modules/aks"

  client_name                  = var.client_name
  tags                         = var.tags
  resource_group_name          = module.create_resource_group.resource_group_name
  primary_location             = var.primary_location
  nodepool_vm_size_1           = var.nodepool_vm_size_1
  nodepool_vm_size_2           = var.nodepool_vm_size_2
  node_minimum_count           = var.node_minimum_count
  node_maximum_count           = var.node_maximum_count
  resource_group_id            = module.create_resource_group.resource_group_id
  is_production                = var.is_production

}

module "create_service_bus" {
  source = "./modules/service-bus"

  client_name                       = var.client_name
  tags                              = var.tags
  resource_group_name               = module.create_resource_group.resource_group_name
  is_production                     = var.is_production
  primary_location                  = var.primary_location

}

module "traffic_manager" {
  source = "./modules/traffic-managers"
  client_name                      = var.client_name
  resource_group_name              = module.create_resource_group.resource_group_name
  tags                             = var.tags
  primary_location                 = var.primary_location
  secondary_location               = var.secondary_location
  parent_zone                      = var.parent_zone
  is_production                    = var.is_production

}

module "create_storage_account" {
  source = "./modules/storage-account"

  tags                             = var.tags
  client_name                      = var.client_name
  resource_group_name              = module.create_resource_group.resource_group_name
  primary_location                 = var.primary_location
  is_production                    = var.is_production

}

module "create_public_ips" {
  source = "./modules/public-ip"

  client_name                       = var.client_name
  tags                              = var.tags
  resource_group_name               = module.create_k8s_clusters.aks_node_rg_1
  primary_location                  = var.primary_location
  secondary_location                = var.secondary_location
  cluster_name_1                    = module.create_k8s_clusters.cluster_name_1
  cluster_name_2                    = module.create_k8s_clusters.cluster_name_2
  parent_zone                       = var.parent_zone
  is_production                     = var.is_production

  # dependencies
  depends_on = [
  module.create_key_vault.akv_id,
  module.create_resource_group.resource_group_id,
  module.create_service_bus.service_bus_id_1,
  module.create_service_bus.service_bus_id_2,
  module.create_storage_account.storage_account_id,
  ]
}

module "create_dns_records" {
  source = "./modules/dns-records"

  client_name                              = var.client_name
  tags                                     = var.tags
  resource_group_name                      = module.create_resource_group.resource_group_name
  dns_resource_group_name                  = var.dns_resource_group_name
  dns_subscription                         = var.dns_subscription 
  primary_location                         = var.primary_location
  secondary_location                       = var.secondary_location
  parent_zone                              = var.parent_zone
  is_production                            = var.is_production
  traffic_manager_ingress_id               = module.traffic_manager.traffic_manager_ingress_profile_id
  traffic_manager_inpost_id                = module.traffic_manager.traffic_manager_inpost_profile_id
  blue_inpost_ip_address                   = module.create_public_ips.blue_inpost_ip_address
  blue_ingress_ip_address                  = module.create_public_ips.blue_ingress_ip_address
  blue_egress_ip_address                   = module.create_public_ips.blue_egress_ip_address
  blue_testing_ip_address                  = module.create_public_ips.blue_testing_ip_address
  green_inpost_ip_address                  = module.create_public_ips.green_inpost_ip_address
  green_ingress_ip_address                 = module.create_public_ips.green_ingress_ip_address
  green_egress_ip_address                  = module.create_public_ips.green_egress_ip_address
  green_testing_ip_address                 = module.create_public_ips.green_testing_ip_address

  # dependencies
  # depends_on = [
  # module.create_public_ips.blue_inpost_ip_address,
  # module.create_public_ips.blue_ingress_ip_address,
  # module.create_public_ips.blue_egress_ip_address,
  # module.create_public_ips.blue_testing_ip_address,
  # module.create_public_ips.green_inpost_ip_address,
  # module.create_public_ips.green_ingress_ip_address,
  # module.create_public_ips.green_egress_ip_address,
  # module.create_public_ips.green_testing_ip_address,
  # ]
}

module "create_key_vault" {
  source = "./modules/key-vault"

  client_name                             = var.client_name
  tags                                    = var.tags
  resource_group_name                     = module.create_resource_group.resource_group_name
  is_production                           = var.is_production
  primary_location                        = var.primary_location
  secondary_location                      = var.secondary_location
  cluster_name_1                          = module.create_k8s_clusters.cluster_name_1
  cluster_name_2                          = module.create_k8s_clusters.cluster_name_2
  azure_tenant_id                         = module.azure_config.tenant_id
  azure_object_id                         = module.azure_config.object_id
  servicebus_namespace_1                  = module.create_service_bus.service_bus_name_1
  servicebus_namespace_2                  = module.create_service_bus.service_bus_name_2
  # blue_inpost_ip_address                  = module.create_public_ips.blue_inpost_ip_address
  # blue_ingress_ip_address                 = module.create_public_ips.blue_ingress_ip_address
  # blue_egress_ip_address                  = module.create_public_ips.blue_egress_ip_address
  # blue_testing_ip_address                 = module.create_public_ips.blue_testing_ip_address
  # green_inpost_ip_address                 = module.create_public_ips.green_inpost_ip_address
  # green_ingress_ip_address                = module.create_public_ips.green_ingress_ip_address
  # green_egress_ip_address                 = module.create_public_ips.green_egress_ip_address
  # green_testing_ip_address                = module.create_public_ips.green_testing_ip_address
  identityserverpassword                  = module.create_sql_servers.identityserverpassword
  #identityserversecondarypassword         = module.create_sql_servers.identityserversecondarypassword
  tenancymanagementpassword               = module.create_sql_servers.tenancymanagementpassword
  #tenancymanagementsecondarypassword      = module.create_sql_servers.tenancymanagementsecondarypassword
  reportsserverpassword                   = module.create_sql_servers.reportsserverpassword
  #reportsserversecondarypassword          = module.create_sql_servers.reportsserversecondarypassword
  policyserverpassword                    = module.create_sql_servers.policyserverpassword
  #policyserversecondarypassword           = module.create_sql_servers.policyserversecondarypassword

  # dependencies

}

module "create_sql_servers" {
  source = "./modules/sql-servers"

  client_name                             = var.client_name
  tags                                    = var.tags
  resource_group_name                     = module.create_resource_group.resource_group_name
  storage_account_name                    = module.create_storage_account.storage_account_name
  storage_account_id                      = module.create_storage_account.storage_account_id
  is_production                           = var.is_production
  primary_location                        = var.primary_location
  secondary_location                      = var.secondary_location
  parent_zone                             = var.parent_zone
}

module "create_redis_cache" {
  source = "./modules/redis"

  client_name                             = var.client_name
  tags                                    = var.tags
  resource_group_name                     = module.create_resource_group.resource_group_name
  primary_location                        = var.primary_location
  deploy_redis                            = var.deploy_redis
}

module "create_vnet" {
  source = "./modules/vnet"

  client_name                             = var.client_name
  tags                                    = var.tags
  resource_group_name                     = module.create_resource_group.resource_group_name
  primary_location                        = var.primary_location
  is_production                           = var.is_production
}
