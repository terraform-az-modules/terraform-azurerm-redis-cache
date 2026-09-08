##-----------------------------------------------------------------------------
## Naming convention
##-----------------------------------------------------------------------------
variable "custom_name" {
  type        = string
  default     = null
  description = "Override default naming convention"
}

variable "resource_position_prefix" {
  type        = bool
  default     = true
  description = <<EOT
Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.

- If true, the keyword is prepended: "vnet-core-dev".
- If false, the keyword is appended: "core-dev-vnet".

This helps maintain naming consistency based on organizational preferences.
EOT
}

##-----------------------------------------------------------------------------
## Labels
##-----------------------------------------------------------------------------
variable "name" {
  type        = string
  default     = "core"
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = "terraform-az-modules"
  description = "ManagedBy, eg 'terraform-az-modules'."
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Variable to pass extra tags."
}

variable "repository" {
  type        = string
  default     = "https://github.com/terraform-az-modules/terraform-azurerm-redis-cache"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "location" {
  type        = string
  default     = "centralus"
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies how the infrastructure/resource is deployed"
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment", "location"]
  description = "The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']."
}

##-----------------------------------------------------------------------------
## Global Variables
##-----------------------------------------------------------------------------

variable "enable" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = "The name of the resource group in which to create the Managed Redis instance."
}

##-----------------------------------------------------------------------------
## Primary Managed Redis Configuration
##-----------------------------------------------------------------------------

variable "sku_name" {
  type        = string
  default     = "Balanced_B1"
  description = "Managed Redis SKU. Possible values: Balanced_B0, Balanced_B1, Balanced_B3, Balanced_B5, Balanced_B10, Balanced_B20, Balanced_B50, Balanced_B100, Balanced_B150, Balanced_B250, Balanced_B350, Balanced_B500, Balanced_B700, Balanced_B1000, ComputeOptimized_X3/X5/X10/X20/X50/X100/X150/X250/X350/X500/X700, FlashOptimized_A250/A500/A700/A1000/A1500/A2000/A4500, MemoryOptimized_M10/M20/M50/M100/M150/M250/M350/M500/M700/M1000/M1500/M2000. Balanced_B3 or higher is required for geo-replication."
}

variable "high_availability_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable high availability for the Managed Redis instance. Defaults to true. Changing this forces a new resource."
}

variable "access_keys_authentication_enabled" {
  type        = bool
  default     = true
  description = "Whether access key authentication is enabled for the default database."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Allow public network access. Maps to public_network_access Enabled/Disabled."
}

variable "client_protocol" {
  type        = string
  default     = "Encrypted"
  description = "Specifies whether redis clients can connect using TLS-encrypted or plaintext redis protocols. Possible values are Encrypted and Plaintext."
}

variable "clustering_policy" {
  type        = string
  default     = "OSSCluster"
  description = "Clustering policy specified at create time. Possible values are EnterpriseCluster, OSSCluster and NoCluster. Changing this forces database recreation."
}

variable "eviction_policy" {
  type        = string
  default     = "VolatileLRU"
  description = "Redis eviction policy. Possible values are AllKeysLFU, AllKeysLRU, AllKeysRandom, VolatileLRU, VolatileLFU, VolatileTTL, VolatileRandom and NoEviction."
}

variable "persistence_aof_backup_frequency" {
  type        = string
  default     = null
  description = "Frequency of Append Only File (AOF) backups. Only possible value is 1s. Conflicts with persistence_rdb_backup_frequency and geo_replication_group_name."
}

variable "persistence_rdb_backup_frequency" {
  type        = string
  default     = null
  description = "Frequency of Redis Database (RDB) backups. Possible values are 1h, 6h and 12h. Conflicts with persistence_aof_backup_frequency and geo_replication_group_name."
}

variable "redis_modules" {
  type = list(object({
    name = string
    args = optional(string)
  }))
  default     = []
  description = "Redis modules to enable. Possible name values: RedisBloom, RedisTimeSeries, RediSearch, RedisJSON. Changing modules forces database recreation. Only RediSearch and RedisJSON are allowed with geo-replication."
}

variable "geo_replication_group_name" {
  type        = string
  default     = null
  description = "Name of the geo-replication group. Required when secondary_enabled is true or linked_managed_redis_ids is set. All members must share the same name. Changing this forces database recreation."
}

variable "linked_managed_redis_ids" {
  type        = list(string)
  default     = []
  description = "Additional Managed Redis IDs to link into the geo-replication group (besides the module-managed secondary). Up to 4 linked IDs total (group of 5 including primary)."
}

variable "cmk_encryption_enabled" {
  type        = bool
  default     = false
  description = "Whether to create CMK or not"
}

variable "geo_replication_cmk_enabled" {
  type        = bool
  default     = false
  description = "Whether to create a dedicated Customer Managed Key (CMK) for the secondary (geo-replicated) Managed Redis instance."
}

variable "key_vault_rbac_auth_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether Role-Based Access Control (RBAC) is enabled for the Key Vault."
}

variable "key_vault_id" {
  type        = string
  default     = null
  description = "Key Vault resource ID used to create the CMK and grant the encryption identity wrap/unwrap permissions."
}

variable "key_type" {
  type        = string
  default     = "RSA-HSM"
  description = "Key type for the Managed Redis CMK. Possible values include RSA and RSA-HSM."
}

variable "key_size" {
  type        = number
  default     = 2048
  description = "Key size for the Managed Redis CMK. Defaults to 2048."
}

variable "key_expiration_date" {
  type        = string
  default     = "2028-12-31T23:59:59Z"
  description = "The expiration date for the Key Vault key in ISO 8601 format."
}

variable "key_permissions" {
  type        = list(string)
  default     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  description = "List of key permissions for the Key Vault key."
}

variable "rotation_policy_config" {
  type = object({
    enabled              = bool
    time_before_expiry   = optional(string, "P30D")
    expire_after         = optional(string, "P90D")
    notify_before_expiry = optional(string, "P29D")
  })
  default = {
    enabled              = false
    time_before_expiry   = "P30D"
    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
  description = "Rotation policy configuration for Key Vault keys."
}

variable "identity_ids" {
  type        = list(string)
  default     = null
  description = "User Assigned Managed Identity IDs to attach when encryption is false."
}

variable "timeouts" {
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default     = null
  description = "Timeouts for the primary Managed Redis resource (create/read/update/delete)."
}

##-----------------------------------------------------------------------------
## Access Policy Configuration
##-----------------------------------------------------------------------------

variable "user_object_id" {
  type        = string
  default     = null
  description = "Object ID of the Azure AD user, group, service principal, or managed identity for access policy assignment."
}

variable "access_policy_assignment_timeouts" {
  type = object({
    create = optional(string)
    read   = optional(string)
    delete = optional(string)
  })
  default     = null
  description = "Timeouts for the Managed Redis access policy assignment (create/read/delete)."
}

##-----------------------------------------------------------------------------
## Secondary Managed Redis Configuration
##-----------------------------------------------------------------------------

variable "secondary_enabled" {
  type        = bool
  default     = false
  description = "Enable secondary Managed Redis instance and include it in geo-replication."
}

variable "secondary_sku_name" {
  type        = string
  default     = "Balanced_B3"
  description = "SKU name for secondary Managed Redis. Balanced_B3 or higher is required for geo-replication."
}

variable "secondary_high_availability_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable high availability for the secondary Managed Redis instance."
}

variable "secondary_access_keys_authentication_enabled" {
  type        = bool
  default     = true
  description = "Enable access key authentication for secondary Managed Redis default database."
}

variable "secondary_location" {
  type        = string
  default     = "eastus"
  description = "Location for secondary Managed Redis."
}

variable "secondary_public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Enable public network access for secondary Managed Redis."
}

variable "secondary_client_protocol" {
  type        = string
  default     = "Encrypted"
  description = "Client protocol for secondary Managed Redis. Possible values are Encrypted and Plaintext."
}

variable "secondary_clustering_policy" {
  type        = string
  default     = "OSSCluster"
  description = "Clustering policy for secondary Managed Redis. Possible values are EnterpriseCluster, OSSCluster and NoCluster."
}

variable "secondary_eviction_policy" {
  type        = string
  default     = "VolatileLRU"
  description = "Eviction policy for secondary Managed Redis."
}

variable "secondary_resource_group_name" {
  type        = string
  default     = null
  description = "Resource group name for secondary Managed Redis."
}

variable "secondary_resource_position_prefix" {
  type        = bool
  default     = true
  description = "Position prefix for secondary Managed Redis name."
}

variable "secondary_redis_modules" {
  type = list(object({
    name = string
    args = optional(string)
  }))
  default     = []
  description = "Redis modules for secondary Managed Redis. Only RediSearch and RedisJSON are allowed with geo-replication."
}

variable "secondary_identity_ids" {
  type        = list(string)
  default     = null
  description = "User Assigned Managed Identity IDs for secondary Managed Redis when encryption is false."
}

variable "secondary_timeouts" {
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default     = null
  description = "Timeouts for the secondary Managed Redis resource."
}

variable "geo_replication_timeouts" {
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default     = null
  description = "Timeouts for the Managed Redis geo-replication resource."
}

##-----------------------------------------------------------------------------
## Private Endpoint & DNS Configuration
##-----------------------------------------------------------------------------

variable "enable_private_endpoint" {
  type        = bool
  default     = true
  description = "Enable private endpoint for Managed Redis."
}

variable "private_dns_zone_ids" {
  type        = string
  default     = null
  description = "The ID of the private DNS zone."
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "Subnet ID for the private endpoint."
}

##-----------------------------------------------------------------------------
## Diagnostic Settings & Monitoring
##-----------------------------------------------------------------------------

variable "enable_diagnostic" {
  type        = bool
  default     = true
  description = "Enable diagnostic settings for Managed Redis"
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "Log Analytics Workspace ID for diagnostics."
}

variable "storage_account_id" {
  type        = string
  default     = null
  description = "Storage account ID for diagnostic settings destination."
}

variable "metric_enabled" {
  type        = bool
  default     = true
  description = "Boolean flag to specify whether Metrics should be enabled. Defaults to true."
}

variable "logs" {
  type = list(object({
    category_group = optional(string)
    category       = optional(string)
  }))
  default     = []
  description = "List of log configurations for diagnostic settings. Each object can specify either category_group or category."
}
