variable "azure_location" {
  description = "Location resources cloud azure"
  type        = string
  default     = "East US"
}

variable "azure_resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "infra-cluster-manager"
}

variable "azure_environment" {
  description = "The environment for the Azure resources, such as 'dev', 'staging', 'hml', or 'prod'."
  type        = string
  default     = "dev"
}

variable "tags_resource_environment" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    environment = "development"
    owner       = "devops-team"
    project     = "platform-engineering"
  }
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster to be created."
  type        = string
  default     = "cluster-manager"
}

variable "cluster_version" {
  description = "Version of the Kubernetes cluster to be created."
  type        = string
  default     = "1.30"
}

variable "cluster_dns_prefix" {
  description = "The DNS prefix to use for the Kubernetes cluster."
  type        = string
  default     = "mngcluster"
}

variable "cluster_nodepool_name" {
  description = "The name of the default node pool in the Kubernetes cluster."
  type        = string
  default     = "admnodes"
}

variable "cluster_nodepool_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 1
}

variable "cluster_nodepool_vmsize" {
  description = "The virtual machine size for the nodes in the default node pool."
  type        = string
  default     = "Standard_D2ps_v5"
}

variable "cluster_nodepool_autoscaling_enabled" {
  description = "Flag to enable or disable autoscaling for the default node pool."
  type        = bool
  default     = false
}

variable "cluster_nodepool_autoscaling_min_count" {
  description = "Minimum number of nodes for the default node pool when autoscaling is enabled."
  type        = number
  default     = 1
}

variable "cluster_nodepool_autoscaling_max_count" {
  description = "Maximum number of nodes for the default node pool when autoscaling is enabled."
  type        = number
  default     = 2
}

variable "cluster_identity" {
  description = "The type of identity to assign to the cluster, e.g., 'SystemAssigned' or 'UserAssigned'."
  type        = string
  default     = "SystemAssigned"
}

variable "cluster_private_enabled" {
  description = "Flag to enable or disable the private cluster configuration."
  type        = bool
  default     = false
}

variable "cluster_network_profile_plugin" {
  description = "The network plugin to use for the cluster, e.g., 'kubenet' or 'azure'."
  type        = string
  default     = "kubenet"
}

variable "cluster_network_service_cidr" {
  description = "The CIDR block for the Kubernetes service network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_network_dns_service_ip" {
  description = "The IP address for the DNS service within the Kubernetes service network."
  type        = string
  default     = "10.0.0.10"
}

variable "cluster_network_pod_cidr" {
  description = "The CIDR block for the Kubernetes pod network."
  type        = string
  default     = "10.244.0.0/16"
}

variable "cluster_network_type_load_balancer_sku" {
  description = "SKU type of the load balancer to be used, either 'standard' or 'basic'."
  type        = string
  default     = "standard"
}

variable "cluster_additional_nodepool_name" {
  description = "The name of the additional node pool for running application workloads."
  type        = string
  default     = "appnodes"
}

variable "cluster_additional_nodepool_count" {
  description = "The number of nodes in the additional node pool for application workloads."
  type        = number
  default     = 2
}

variable "cluster_additional_nodepool_vmsize" {
  description = "The virtual machine size for the nodes in the additional node pool."
  type        = string
  default     = "Standard_D2ps_v5"
}

variable "cluster_additional_nodepool_autoscaling_enabled" {
  description = "Flag to enable or disable autoscaling for the additional node pool."
  type        = bool
  default     = true
}

variable "cluster_additional_nodepool_autoscaling_min_count" {
  description = "Minimum number of nodes for the additional node pool when autoscaling is enabled."
  type        = number
  default     = 1
}

variable "cluster_additional_nodepool_autoscaling_max_count" {
  description = "Maximum number of nodes for the additional node pool when autoscaling is enabled."
  type        = number
  default     = 4
}

variable "cluster_additional_nodepool_labels" {
  description = "Labels to assign to the additional node pool for identification and organization."
  type        = map(string)
  default = {
    environment = "applications"
  }
}

variable "cluster_network_security_name" {
  description = "Name of the network security group (NSG) associated with the cluster."
  type        = string
  default     = "aks-nsg"
}

variable "cluster_network_security_rules" {
  description = "Map of security rules"
  type = map(object({
    sg_name                       = string
    sg_priority                   = number
    sg_direction                  = string
    sg_access                     = string
    sg_protocol                   = string
    sg_source_port_range          = string
    sg_destination_port_range     = string
    sg_source_address_prefix      = string
    sg_destination_address_prefix = string
  }))

  default = {
    allow_http = {
      sg_name                       = "Allow-HTTP"
      sg_priority                   = 1000
      sg_direction                  = "Inbound"
      sg_access                     = "Allow"
      sg_protocol                   = "Tcp"
      sg_source_port_range          = "*"
      sg_destination_port_range     = "80"
      sg_source_address_prefix      = "*"
      sg_destination_address_prefix = "*"
    },
    allow_https = {
      sg_name                       = "Allow-HTTPS"
      sg_priority                   = 1001
      sg_direction                  = "Inbound"
      sg_access                     = "Allow"
      sg_protocol                   = "Tcp"
      sg_source_port_range          = "*"
      sg_destination_port_range     = "443"
      sg_source_address_prefix      = "*"
      sg_destination_address_prefix = "*"
    }
  }
}

variable "vpc_name" {
  description = "Name of the virtual private cloud (VPC) to be created."
  type        = string
  default     = "main-vnet"
}

variable "vpc_address_space" {
  description = "Address space for the virtual private cloud (VPC) in CIDR format."
  type        = list(string)
  default     = ["10.30.0.0/16"]
}

variable "vpc_subnet_cluster_name" {
  description = "Name of the subnet to be created for the AKS cluster."
  type        = string
  default     = "aks-subnet"
}

variable "vpc_subnet_cluster_address_prefixes" {
  description = "Address prefixes for the subnet of the AKS cluster in CIDR format."
  type        = list(string)
  default     = ["10.30.1.0/24"]
}




