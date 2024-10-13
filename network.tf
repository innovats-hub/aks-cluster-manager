resource "azurerm_virtual_network" "vnet" {
  name                = var.vpc_name
  address_space       = var.vpc_address_space
  location            = azurerm_resource_group.cluster_manager.location
  resource_group_name = azurerm_resource_group.cluster_manager.name

  tags = var.tags_resource_environment

  depends_on = [azurerm_resource_group.cluster_manager]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = var.vpc_subnet_cluster_name
  resource_group_name  = azurerm_resource_group.cluster_manager.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vpc_subnet_cluster_address_prefixes

  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_network_security_group" "aks_nsg" {
  name                = var.cluster_network_security_name
  location            = azurerm_resource_group.cluster_manager.location
  resource_group_name = azurerm_resource_group.cluster_manager.name

  dynamic "security_rule" {
    for_each = var.cluster_network_security_rules

    content {
      name                       = security_rule.value.sg_name
      priority                   = security_rule.value.sg_priority
      direction                  = security_rule.value.sg_direction
      access                     = security_rule.value.sg_access
      protocol                   = security_rule.value.sg_protocol
      source_port_range          = security_rule.value.sg_source_port_range
      destination_port_range     = security_rule.value.sg_destination_port_range
      source_address_prefix      = security_rule.value.sg_source_address_prefix
      destination_address_prefix = security_rule.value.sg_destination_address_prefix
    }
  }

  depends_on = [azurerm_resource_group.cluster_manager]
}

resource "azurerm_subnet_network_security_group_association" "aks_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.aks_subnet.id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id

  depends_on = [azurerm_network_security_group.aks_nsg, azurerm_subnet.aks_subnet]
}
