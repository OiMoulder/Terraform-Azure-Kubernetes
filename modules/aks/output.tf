output "cluster_name_1" {
  value = azurerm_kubernetes_cluster.aks1.name
}

output "cluster_name_2" {
  value = azurerm_kubernetes_cluster.aks2.name
}

output "aks_id_1" {
  value = azurerm_kubernetes_cluster.aks1.id
}

output "aks_id_2" {
  value = azurerm_kubernetes_cluster.aks2.id
}

output "aks_node_rg_1" {
  value = azurerm_kubernetes_cluster.aks1.node_resource_group
}

output "aks_node_rg_2" {
  value = azurerm_kubernetes_cluster.aks2.node_resource_group
}

output "private_fqdn_1" {
  value = azurerm_kubernetes_cluster.aks1.private_fqdn
}

output "private_fqdn_2" {
  value = azurerm_kubernetes_cluster.aks2.private_fqdn
}

output "principal_id_1" {
  value = azurerm_kubernetes_cluster.aks1.kubelet_identity.0.object_id
}

output "principal_id_2" {
  value = azurerm_kubernetes_cluster.aks2.kubelet_identity.0.object_id
}