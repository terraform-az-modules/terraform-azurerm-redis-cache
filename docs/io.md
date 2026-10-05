## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | terraform-az-modules/tags/azurerm | 1.0.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_key.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_key.secondary_cmk_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_managed_redis.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_redis) | resource |
| [azurerm_managed_redis.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_redis) | resource |
| [azurerm_managed_redis_access_policy_assignment.identity_assigned](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_redis_access_policy_assignment) | resource |
| [azurerm_managed_redis_geo_replication.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_redis_geo_replication) | resource |
| [azurerm_monitor_diagnostic_setting.diag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.identity_assigned](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.secondary_identity_assigned](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.secondary_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_keys_authentication_enabled"></a> [access\_keys\_authentication\_enabled](#input\_access\_keys\_authentication\_enabled) | Whether access key authentication is enabled for the default database. | `bool` | `true` | no |
| <a name="input_access_policy_assignment_timeouts"></a> [access\_policy\_assignment\_timeouts](#input\_access\_policy\_assignment\_timeouts) | Timeouts for the Managed Redis access policy assignment (create/read/delete). | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_client_protocol"></a> [client\_protocol](#input\_client\_protocol) | Specifies whether redis clients can connect using TLS-encrypted or plaintext redis protocols. Possible values are Encrypted and Plaintext. | `string` | `"Encrypted"` | no |
| <a name="input_clustering_policy"></a> [clustering\_policy](#input\_clustering\_policy) | Clustering policy specified at create time. Possible values are EnterpriseCluster, OSSCluster and NoCluster. Changing this forces database recreation. | `string` | `"OSSCluster"` | no |
| <a name="input_cmk_encryption_enabled"></a> [cmk\_encryption\_enabled](#input\_cmk\_encryption\_enabled) | Whether to create CMK or not | `bool` | `false` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Override default naming convention | `string` | `null` | no |
| <a name="input_deployment_mode"></a> [deployment\_mode](#input\_deployment\_mode) | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| <a name="input_enable_diagnostic"></a> [enable\_diagnostic](#input\_enable\_diagnostic) | Enable diagnostic settings for Managed Redis | `bool` | `true` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Enable private endpoint for Managed Redis. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `"dev"` | no |
| <a name="input_eviction_policy"></a> [eviction\_policy](#input\_eviction\_policy) | Redis eviction policy. Possible values are AllKeysLFU, AllKeysLRU, AllKeysRandom, VolatileLRU, VolatileLFU, VolatileTTL, VolatileRandom and NoEviction. | `string` | `"VolatileLRU"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Variable to pass extra tags. | `map(string)` | `null` | no |
| <a name="input_geo_replication_cmk_enabled"></a> [geo\_replication\_cmk\_enabled](#input\_geo\_replication\_cmk\_enabled) | Whether to create a dedicated Customer Managed Key (CMK) for the secondary (geo-replicated) Managed Redis instance. | `bool` | `false` | no |
| <a name="input_geo_replication_group_name"></a> [geo\_replication\_group\_name](#input\_geo\_replication\_group\_name) | Name of the geo-replication group. Required when secondary\_enabled is true or linked\_managed\_redis\_ids is set. All members must share the same name. Changing this forces database recreation. | `string` | `null` | no |
| <a name="input_geo_replication_timeouts"></a> [geo\_replication\_timeouts](#input\_geo\_replication\_timeouts) | Timeouts for the Managed Redis geo-replication resource. | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_high_availability_enabled"></a> [high\_availability\_enabled](#input\_high\_availability\_enabled) | Whether to enable high availability for the Managed Redis instance. Defaults to true. Changing this forces a new resource. | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | User Assigned Managed Identity IDs to attach when encryption is false. | `list(string)` | `null` | no |
| <a name="input_key_expiration_date"></a> [key\_expiration\_date](#input\_key\_expiration\_date) | The expiration date for the Key Vault key in ISO 8601 format. | `string` | `"2028-12-31T23:59:59Z"` | no |
| <a name="input_key_permissions"></a> [key\_permissions](#input\_key\_permissions) | List of key permissions for the Key Vault key. | `list(string)` | <pre>[<br/>  "decrypt",<br/>  "encrypt",<br/>  "sign",<br/>  "unwrapKey",<br/>  "verify",<br/>  "wrapKey"<br/>]</pre> | no |
| <a name="input_key_size"></a> [key\_size](#input\_key\_size) | Key size for the Managed Redis CMK. Defaults to 2048. | `number` | `2048` | no |
| <a name="input_key_type"></a> [key\_type](#input\_key\_type) | Key type for the Managed Redis CMK. Possible values include RSA and RSA-HSM. | `string` | `"RSA-HSM"` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Key Vault resource ID used to create the CMK and grant the encryption identity wrap/unwrap permissions. | `string` | `null` | no |
| <a name="input_key_vault_rbac_auth_enabled"></a> [key\_vault\_rbac\_auth\_enabled](#input\_key\_vault\_rbac\_auth\_enabled) | Specifies whether Role-Based Access Control (RBAC) is enabled for the Key Vault. | `bool` | `true` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']. | `list(any)` | <pre>[<br/>  "name",<br/>  "environment",<br/>  "location"<br/>]</pre> | no |
| <a name="input_linked_managed_redis_ids"></a> [linked\_managed\_redis\_ids](#input\_linked\_managed\_redis\_ids) | Additional Managed Redis IDs to link into the geo-replication group (besides the module-managed secondary). Up to 4 linked IDs total (group of 5 including primary). | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `"centralus"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Log Analytics Workspace ID for diagnostics. | `string` | `null` | no |
| <a name="input_logs"></a> [logs](#input\_logs) | List of log configurations for diagnostic settings. Each object can specify either category\_group or category. | <pre>list(object({<br/>    category_group = optional(string)<br/>    category       = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'terraform-az-modules'. | `string` | `"terraform-az-modules"` | no |
| <a name="input_metric_enabled"></a> [metric\_enabled](#input\_metric\_enabled) | Boolean flag to specify whether Metrics should be enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `"core"` | no |
| <a name="input_persistence_aof_backup_frequency"></a> [persistence\_aof\_backup\_frequency](#input\_persistence\_aof\_backup\_frequency) | Frequency of Append Only File (AOF) backups. Only possible value is 1s. Conflicts with persistence\_rdb\_backup\_frequency and geo\_replication\_group\_name. | `string` | `null` | no |
| <a name="input_persistence_rdb_backup_frequency"></a> [persistence\_rdb\_backup\_frequency](#input\_persistence\_rdb\_backup\_frequency) | Frequency of Redis Database (RDB) backups. Possible values are 1h, 6h and 12h. Conflicts with persistence\_aof\_backup\_frequency and geo\_replication\_group\_name. | `string` | `null` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | The ID of the private DNS zone. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Allow public network access. Maps to public\_network\_access Enabled/Disabled. | `bool` | `false` | no |
| <a name="input_redis_modules"></a> [redis\_modules](#input\_redis\_modules) | Redis modules to enable. Possible name values: RedisBloom, RedisTimeSeries, RediSearch, RedisJSON. Changing modules forces database recreation. Only RediSearch and RedisJSON are allowed with geo-replication. | <pre>list(object({<br/>    name = string<br/>    args = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/terraform-az-modules/terraform-azurerm-redis-cache"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Managed Redis instance. | `string` | `null` | no |
| <a name="input_resource_position_prefix"></a> [resource\_position\_prefix](#input\_resource\_position\_prefix) | Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.<br/><br/>- If true, the keyword is prepended: "vnet-core-dev".<br/>- If false, the keyword is appended: "core-dev-vnet".<br/><br/>This helps maintain naming consistency based on organizational preferences. | `bool` | `true` | no |
| <a name="input_rotation_policy_config"></a> [rotation\_policy\_config](#input\_rotation\_policy\_config) | Rotation policy configuration for Key Vault keys. | <pre>object({<br/>    enabled              = bool<br/>    time_before_expiry   = optional(string, "P30D")<br/>    expire_after         = optional(string, "P90D")<br/>    notify_before_expiry = optional(string, "P29D")<br/>  })</pre> | <pre>{<br/>  "enabled": false,<br/>  "expire_after": "P90D",<br/>  "notify_before_expiry": "P29D",<br/>  "time_before_expiry": "P30D"<br/>}</pre> | no |
| <a name="input_secondary_access_keys_authentication_enabled"></a> [secondary\_access\_keys\_authentication\_enabled](#input\_secondary\_access\_keys\_authentication\_enabled) | Enable access key authentication for secondary Managed Redis default database. | `bool` | `true` | no |
| <a name="input_secondary_client_protocol"></a> [secondary\_client\_protocol](#input\_secondary\_client\_protocol) | Client protocol for secondary Managed Redis. Possible values are Encrypted and Plaintext. | `string` | `"Encrypted"` | no |
| <a name="input_secondary_clustering_policy"></a> [secondary\_clustering\_policy](#input\_secondary\_clustering\_policy) | Clustering policy for secondary Managed Redis. Possible values are EnterpriseCluster, OSSCluster and NoCluster. | `string` | `"OSSCluster"` | no |
| <a name="input_secondary_enabled"></a> [secondary\_enabled](#input\_secondary\_enabled) | Enable secondary Managed Redis instance and include it in geo-replication. | `bool` | `false` | no |
| <a name="input_secondary_eviction_policy"></a> [secondary\_eviction\_policy](#input\_secondary\_eviction\_policy) | Eviction policy for secondary Managed Redis. | `string` | `"VolatileLRU"` | no |
| <a name="input_secondary_high_availability_enabled"></a> [secondary\_high\_availability\_enabled](#input\_secondary\_high\_availability\_enabled) | Whether to enable high availability for the secondary Managed Redis instance. | `bool` | `true` | no |
| <a name="input_secondary_identity_ids"></a> [secondary\_identity\_ids](#input\_secondary\_identity\_ids) | User Assigned Managed Identity IDs for secondary Managed Redis when encryption is false. | `list(string)` | `null` | no |
| <a name="input_secondary_location"></a> [secondary\_location](#input\_secondary\_location) | Location for secondary Managed Redis. | `string` | `"eastus"` | no |
| <a name="input_secondary_public_network_access_enabled"></a> [secondary\_public\_network\_access\_enabled](#input\_secondary\_public\_network\_access\_enabled) | Enable public network access for secondary Managed Redis. | `bool` | `false` | no |
| <a name="input_secondary_redis_modules"></a> [secondary\_redis\_modules](#input\_secondary\_redis\_modules) | Redis modules for secondary Managed Redis. Only RediSearch and RedisJSON are allowed with geo-replication. | <pre>list(object({<br/>    name = string<br/>    args = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_secondary_resource_group_name"></a> [secondary\_resource\_group\_name](#input\_secondary\_resource\_group\_name) | Resource group name for secondary Managed Redis. | `string` | `null` | no |
| <a name="input_secondary_resource_position_prefix"></a> [secondary\_resource\_position\_prefix](#input\_secondary\_resource\_position\_prefix) | Position prefix for secondary Managed Redis name. | `bool` | `true` | no |
| <a name="input_secondary_sku_name"></a> [secondary\_sku\_name](#input\_secondary\_sku\_name) | SKU name for secondary Managed Redis. Balanced\_B3 or higher is required for geo-replication. | `string` | `"Balanced_B3"` | no |
| <a name="input_secondary_timeouts"></a> [secondary\_timeouts](#input\_secondary\_timeouts) | Timeouts for the secondary Managed Redis resource. | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Managed Redis SKU. Possible values: Balanced\_B0, Balanced\_B1, Balanced\_B3, Balanced\_B5, Balanced\_B10, Balanced\_B20, Balanced\_B50, Balanced\_B100, Balanced\_B150, Balanced\_B250, Balanced\_B350, Balanced\_B500, Balanced\_B700, Balanced\_B1000, ComputeOptimized\_X3/X5/X10/X20/X50/X100/X150/X250/X350/X500/X700, FlashOptimized\_A250/A500/A700/A1000/A1500/A2000/A4500, MemoryOptimized\_M10/M20/M50/M100/M150/M250/M350/M500/M700/M1000/M1500/M2000. Balanced\_B3 or higher is required for geo-replication. | `string` | `"Balanced_B1"` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | Storage account ID for diagnostic settings destination. | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID for the private endpoint. | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeouts for the primary Managed Redis resource (create/read/update/delete). | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_user_object_id"></a> [user\_object\_id](#input\_user\_object\_id) | Object ID of the Azure AD user, group, service principal, or managed identity for access policy assignment. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_id"></a> [database\_id](#output\_database\_id) | The ID of the Managed Redis default database |
| <a name="output_default_database"></a> [default\_database](#output\_default\_database) | The full default\_database block of the Managed Redis instance |
| <a name="output_geo_replication_group_name"></a> [geo\_replication\_group\_name](#output\_geo\_replication\_group\_name) | Geo-replication group name applied to the Managed Redis databases |
| <a name="output_geo_replication_id"></a> [geo\_replication\_id](#output\_geo\_replication\_id) | The ID of the Managed Redis Geo-Replication resource |
| <a name="output_high_availability_enabled"></a> [high\_availability\_enabled](#output\_high\_availability\_enabled) | Whether high availability is enabled |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | DNS name of the Managed Redis cluster endpoint |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Managed Redis instance |
| <a name="output_linked_managed_redis_ids"></a> [linked\_managed\_redis\_ids](#output\_linked\_managed\_redis\_ids) | Managed Redis IDs linked in the geo-replication group |
| <a name="output_location"></a> [location](#output\_location) | The Azure Region of the Managed Redis instance |
| <a name="output_name"></a> [name](#output\_name) | The name of the Managed Redis instance |
| <a name="output_port"></a> [port](#output\_port) | TCP port of the Managed Redis default database endpoint |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the Managed Redis default database (exported when access\_keys\_authentication\_enabled is true) |
| <a name="output_public_network_access"></a> [public\_network\_access](#output\_public\_network\_access) | Public network access setting (Enabled or Disabled) |
| <a name="output_redis_modules"></a> [redis\_modules](#output\_redis\_modules) | Redis modules configured on the default database, including computed version |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The Resource Group of the Managed Redis instance |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for the Managed Redis default database (exported when access\_keys\_authentication\_enabled is true) |
| <a name="output_secondary_database_id"></a> [secondary\_database\_id](#output\_secondary\_database\_id) | The ID of the secondary Managed Redis default database |
| <a name="output_secondary_hostname"></a> [secondary\_hostname](#output\_secondary\_hostname) | The hostname of the secondary Managed Redis instance |
| <a name="output_secondary_id"></a> [secondary\_id](#output\_secondary\_id) | The ID of the secondary Managed Redis instance |
| <a name="output_secondary_name"></a> [secondary\_name](#output\_secondary\_name) | The name of the secondary Managed Redis instance |
| <a name="output_secondary_port"></a> [secondary\_port](#output\_secondary\_port) | TCP port of the secondary Managed Redis default database |
| <a name="output_secondary_primary_access_key"></a> [secondary\_primary\_access\_key](#output\_secondary\_primary\_access\_key) | Primary access key for the secondary Managed Redis default database |
| <a name="output_secondary_redis_modules"></a> [secondary\_redis\_modules](#output\_secondary\_redis\_modules) | Redis modules on the secondary Managed Redis default database, including computed version |
| <a name="output_secondary_secondary_access_key"></a> [secondary\_secondary\_access\_key](#output\_secondary\_secondary\_access\_key) | Secondary access key for the secondary Managed Redis default database |
| <a name="output_sku_name"></a> [sku\_name](#output\_sku\_name) | The SKU name of the Managed Redis instance |
