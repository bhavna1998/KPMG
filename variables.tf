variable "key_vault_name" {
  type        = string
  description = "The ID of the Key Vault from which all Secrets should be sourced"
}

variable "key_vault_rg_name" {
  type        = string
  description = "Name of the resource group in which key vault exists"
}

variable "storage_accounts" {
  type = map(object({
    name                              = string
    resource_group_name               = string
    location                          = string
    sku                               = string
    account_kind                      = string
    access_tier                       = string
    enable_cmke                       = bool
    create_new_key_vault_key          = bool
    key_vault_key_name                = string
    min_tls_version                   = string
    public_network_access_enabled     = bool
    enable_https_traffic_only         = bool
    shared_access_key_enabled         = bool
    infrastructure_encryption_enabled = bool
    identity_type                     = string
    identity_ids                      = list(string)
    additional_tags                   = map(string)
    network_rules = object({
      bypass                     = list(string)
      default_action             = string
      ip_rules                   = list(string)
      virtual_network_subnet_ids = list(string)
    })
    private_endpoint = list(object({
      name                   = string
      subnet_name            = string
      vnet_name              = string
      vnet_rg_name           = string
      is_manual_connection   = bool
      subresource_names      = list(string)
      private_dns_zone_group = string
      private_dns_zones = list(object({
        dns_zone_name       = string
        resource_group_name = string
        subscription_id     = string
      }))
    }))
  }))
  description = "Map of storage accouts which needs to be created in a resource group"
  default     = {}
}

variable "containers" {
  type = list(object({
    container_name        = string
    storage_account_name  = string
    container_access_type = string
    metadata              = map(any)
  }))
  description = "Map of Storage Containers"
  default     = []
}

variable "blobs" {
  type = list(object({
    name                   = string
    storage_account_name   = string
    storage_container_name = string
    type                   = string
    size                   = number
    content_type           = string
    source                 = string
    metadata               = map(any)
  }))
  description = "Map of Storage Blobs"
  default     = []
}

variable "queues" {
  type = list(object({
    queue_name           = string
    storage_account_name = string
  }))
  description = "Map of Storages Queues"
  default     = []
}

variable "file_shares" {
  type = list(object({
    share_name           = string
    storage_account_name = string
    quota                = number
  }))
  description = "Map of Storages File Shares"
  default     = []
}

variable "tables" {
  type = list(object({
    table_name           = string
    storage_account_name = string
  }))
  description = "Map of Storage Tables"
  default     = []
}