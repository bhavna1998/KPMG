variable "aks_additional_tags" {
  type        = map(string)
  default     = null
  description = "Tags to be added for AKS"
}
variable "aks" {
  type = map(object({
    resource_group_name              = string
    name                             = string
    sku_tier                         = string
    dns_prefix                       = string
    kubernetes_version               = string
    private_cluster_enabled          = bool
    private_dns_zone_id              = string
    local_account_disabled           = bool
    azure_monitoring_enabled         = bool
    law_name                         = string
    law_rg_name                      = string
    azure_policy_enabled             = bool
    http_application_routing_enabled = bool
    enable_secret_store_csi_driver   = bool
    secret_store = object({
      secret_rotation_enabled  = bool
      secret_rotation_interval = string
    })
    network_plugin              = string
    network_policy              = string
    service_cidr                = string
    dns_service_ip              = string
    docker_bridge_cidr          = string
    load_balancer_sku           = string
    outbound_type               = string
    automatic_channel_upgrade   = string
    maintenance_window_enabled = bool
    maintenance_window = object({
      day   = string
      hours = list(number)
    })
    oidc_issuer_enabled              = bool
    systempool_name                  = string
    systempool_availability_zones    = list(string)
    systempool_type                  = string
    systempool_node_count            = number
    systempool_vm_size               = string
    systempool_enable_auto_scaling   = bool
    systempool_max_count             = number
    systempool_min_count             = number
    systempool_os_disk_type          = string
    systempool_os_disk_size_gb       = number
    systempool_max_pods              = number
    systempool_enable_node_public_ip = bool
    systempool_node_subnet_name      = string
    systempool_node_vnet_name        = string
    systempool_node_vnet_rg_name     = string
    systempool_pod_subnet_name       = string
    systempool_pod_vnet_name         = string
    systempool_pod_vnet_rg_name      = string
    only_critical_addons_enabled     = bool
    rbac_enabled                     = bool
    identity_type                    = string
    identity_ids                     = list(string)
    aad_enabled                      = bool
    aad = object({
      aad_managed            = bool
      admin_group_object_ids = list(string)
      aad_rbac_enabled       = bool
      client_app_id          = string
      server_app_id          = string
      server_app_secret      = string
    })
    http_proxy                     = string
    https_proxy                    = string
    no_proxy                       = list(string)
    cmk_enabled                    = bool
    disk_encryption_set_name       = string
    disk_encryption_rg_name        = string
    acr_id                         = string
  }))
  description = "Values for aks"
}

variable "aks_userpool" {
  type = map(object({
    name                           = string
    aks_name                       = string
    userpool_availability_zones    = list(string)
    userpool_os_disk_size_gb       = number
    userpool_os_disk_type          = string
    userpool_node_count            = number
    userpool_vm_size               = string
    userpool_enable_auto_scaling   = bool
    userpool_max_count             = number
    userpool_min_count             = number
    userpool_os_type               = string
    userpool_max_pods              = number
    userpool_enable_node_public_ip = bool
    nodepool_node_subnet_name      = string
    nodepool_node_vnet_name        = string
    nodepool_node_vnet_rg_name     = string
    nodepool_pod_subnet_name       = string
    nodepool_pod_vnet_name         = string
    nodepool_pod_vnet_rg_name      = string
  }))
  description = "Values for Cluster nodepool"
}
