output "aks_cluster_name" {
  description = "Name of the AKS Cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_api_server_url" {
  description = "URL of the AKS API server"
  sensitive   = true
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "default_node_pool_name" {
  description = "Name of the default Node Pool"
  value       = azurerm_kubernetes_cluster.aks.default_node_pool.0.name
}

output "app_node_pool_name" {
  description = "Name of the additional Node Pool for applications"
  value       = azurerm_kubernetes_cluster_node_pool.app_node_pool.name
}