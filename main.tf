resource "azurerm_resource_group" "cluster_manager" {
  name     = var.azure_resource_group_name
  location = var.azure_location

  tags = var.tags_resource_environment
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.cluster_manager.location
  resource_group_name = azurerm_resource_group.cluster_manager.name
  dns_prefix          = var.cluster_dns_prefix
  kubernetes_version  = var.cluster_version

  default_node_pool {
    name                 = var.cluster_nodepool_name
    node_count           = var.cluster_nodepool_count
    vm_size              = var.cluster_nodepool_vmsize
    vnet_subnet_id       = azurerm_subnet.aks_subnet.id
    auto_scaling_enabled = var.cluster_nodepool_autoscaling_enabled
    min_count            = var.cluster_nodepool_autoscaling_enabled ? var.cluster_nodepool_autoscaling_min_count : null
    max_count            = var.cluster_nodepool_autoscaling_enabled ? var.cluster_nodepool_autoscaling_max_count : null
  }

  identity {
    type = var.cluster_identity
  }

  network_profile {
    network_plugin    = var.cluster_network_profile_plugin
    service_cidr      = var.cluster_network_service_cidr
    dns_service_ip    = var.cluster_network_dns_service_ip
    pod_cidr          = var.cluster_network_pod_cidr
    load_balancer_sku = var.cluster_network_type_load_balancer_sku
  }

  private_cluster_enabled = var.cluster_private_enabled
  tags                    = var.tags_resource_environment

  depends_on = [azurerm_subnet.aks_subnet]
}

resource "azurerm_kubernetes_cluster_node_pool" "app_node_pool" {
  name                  = var.cluster_additional_nodepool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.cluster_additional_nodepool_vmsize
  node_count            = var.cluster_additional_nodepool_count
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  auto_scaling_enabled  = var.cluster_additional_nodepool_autoscaling_enabled
  min_count             = var.cluster_additional_nodepool_autoscaling_enabled ? var.cluster_additional_nodepool_autoscaling_min_count : null
  max_count             = var.cluster_additional_nodepool_autoscaling_enabled ? var.cluster_additional_nodepool_autoscaling_max_count : null
  tags                  = var.tags_resource_environment

  depends_on = [azurerm_kubernetes_cluster.aks]
}