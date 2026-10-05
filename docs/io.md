## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_keys\_authentication\_enabled | Whether access key authentication is enabled for the default database. | `bool` | `true` | no |
| client\_protocol | Specifies whether redis clients can connect using TLS-encrypted or plaintext redis protocols. Possible values are Encrypted and Plaintext. | `string` | `"Encrypted"` | no |
| clustering\_policy | Clustering policy specified at create time. Possible values are EnterpriseCluster, OSSCluster and NoCluster. Changing this forces database recreation. | `string` | `"OSSCluster"` | no |
| cmk\_encryption\_enabled | Whether to create CMK or not | `bool` | `false` | no |
| custom\_name | Override default naming convention | `string` | `null` | no |
| deployment\_mode | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| enable | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| enable\_diagnostic | Enable diagnostic settings for Managed Redis | `bool` | `true` | no |
| enable\_private\_endpoint | Enable private endpoint for Managed Redis. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `"dev"` | no |
| eviction\_policy | Redis eviction policy. Possible values are AllKeysLFU, AllKeysLRU, AllKeysRandom, VolatileLRU, VolatileLFU, VolatileTTL, VolatileRandom and NoEviction. | `string` | `"VolatileLRU"` | no |
| extra\_tags | Variable to pass extra tags. | `map(string)` | `null` | no |
| geo\_replication\_cmk\_enabled | Whether to create a dedicated Customer Managed Key (CMK) for the secondary (geo-replicated) Managed Redis instance. | `bool` | `false` | no |
| geo\_replication\_group\_name | Name of the geo-replication group. Required when secondary\_enabled is true or linked\_managed\_redis\_ids is set. All members must share the same name. Changing this forces database recreation. | `string` | `null` | no |
| geo\_replication\_timeouts | Timeouts for the Managed Redis geo-replication resource. | <pre>object({<br>    create = optional(string)<br>    read   = optional(string)<br>    update = optional(string)<br>    delete = optional(string)<br>  })</pre> | `null` | no |
| high\_availability\_enabled | Whether to enable high availability for the Managed Redis instance. Defaults to true. Changing this forces a new resource. | `bool` | `true` | no |
| identity\_ids | User Assigned Managed Identity IDs to attach when encryption is false. | `list(string)` | `null` | no |
| key\_expiration\_date | The expiration date for the Key Vault key in ISO 8601 format. | `string` | `"2028-12-31T23:59:59Z"` | no |
| key\_permissions | List of key permissions for the Key Vault key. | `list(string)` | <pre>[<br>  "decrypt",<br>  "encrypt",<br>  "sign",<br>  "unwrapKey",<br>  "verify",<br>  "wrapKey"<br>]</pre> | no |
| key\_size | Key size for the Managed Redis CMK. Defaults to 2048. | `number` | `2048` | no |
| key\_type | Key type for the Managed Redis CMK. Possible values include RSA and RSA-HSM. | `string` | `"RSA-HSM"` | no |
| key\_vault\_id | Key Vault resource ID used to create the CMK and grant the encryption identity wrap/unwrap permissions. | `string` | `null` | no |
| key\_vault\_rbac\_auth\_enabled | Specifies whether Role-Based Access Control (RBAC) is enabled for the Key Vault. | `bool` | `true` | no |
| label\_order | The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']. | `list(any)` | <pre>[<br>  "name",<br>  "environment",<br>  "location"<br>]</pre> | no |
| linked\_managed\_redis\_ids | Additional Managed Redis IDs to link into the geo-replication group (besides the module-managed secondary). Up to 4 linked IDs total (group of 5 including primary). | `list(string)` | `[]` | no |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `"centralus"` | no |
| log\_analytics\_workspace\_id | Log Analytics Workspace ID for diagnostics. | `string` | `null` | no |
| logs | List of log configurations for diagnostic settings. Each object can specify either category\_group or category. | <pre>list(object({<br>    category_group = optional(string)<br>    category       = optional(string)<br>  }))</pre> | `[]` | no |
| managedby | ManagedBy, eg 'terraform-az-modules'. | `string` | `"terraform-az-modules"` | no |
| metric\_enabled | Boolean flag to specify whether Metrics should be enabled. Defaults to true. | `bool` | `true` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `"core"` | no |
| persistence\_aof\_backup\_frequency | Frequency of Append Only File (AOF) backups. Only possible value is 1s. Conflicts with persistence\_rdb\_backup\_frequency and geo\_replication\_group\_name. | `string` | `null` | no |
| persistence\_rdb\_backup\_frequency | Frequency of Redis Database (RDB) backups. Possible values are 1h, 6h and 12h. Conflicts with persistence\_aof\_backup\_frequency and geo\_replication\_group\_name. | `string` | `null` | no |
| private\_dns\_zone\_ids | The ID of the private DNS zone. | `string` | `null` | no |
| public\_network\_access\_enabled | Allow public network access. Maps to public\_network\_access Enabled/Disabled. | `bool` | `false` | no |
| redis\_modules | Redis modules to enable. Possible name values: RedisBloom, RedisTimeSeries, RediSearch, RedisJSON. Changing modules forces database recreation. Only RediSearch and RedisJSON are allowed with geo-replication. | <pre>list(object({<br>    name = string<br>    args = optional(string)<br>  }))</pre> | `[]` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/terraform-az-modules/terraform-azurerm-redis-cache"` | no |
| resource\_group\_name | The name of the resource group in which to create the Managed Redis instance. | `string` | `null` | no |
| resource\_position\_prefix | Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.<br><br>- If true, the keyword is prepended: "vnet-core-dev".<br>- If false, the keyword is appended: "core-dev-vnet".<br><br>This helps maintain naming consistency based on organizational preferences. | `bool` | `true` | no |
| rotation\_policy\_config | Rotation policy configuration for Key Vault keys. | <pre>object({<br>    enabled              = bool<br>    time_before_expiry   = optional(string, "P30D")<br>    expire_after         = optional(string, "P90D")<br>    notify_before_expiry = optional(string, "P29D")<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "expire_after": "P90D",<br>  "notify_before_expiry": "P29D",<br>  "time_before_expiry": "P30D"<br>}</pre> | no |
| secondary\_access\_keys\_authentication\_enabled | Enable access key authentication for secondary Managed Redis default database. | `bool` | `true` | no |
| secondary\_client\_protocol | Client protocol for secondary Managed Redis. Possible values are Encrypted and Plaintext. | `string` | `"Encrypted"` | no |
| secondary\_clustering\_policy | Clustering policy for secondary Managed Redis. Possible values are EnterpriseCluster, OSSCluster and NoCluster. | `string` | `"OSSCluster"` | no |
| secondary\_enabled | Enable secondary Managed Redis instance and include it in geo-replication. | `bool` | `false` | no |
| secondary\_eviction\_policy | Eviction policy for secondary Managed Redis. | `string` | `"VolatileLRU"` | no |
| secondary\_high\_availability\_enabled | Whether to enable high availability for the secondary Managed Redis instance. | `bool` | `true` | no |
| secondary\_identity\_ids | User Assigned Managed Identity IDs for secondary Managed Redis when encryption is false. | `list(string)` | `null` | no |
| secondary\_location | Location for secondary Managed Redis. | `string` | `"eastus"` | no |
| secondary\_public\_network\_access\_enabled | Enable public network access for secondary Managed Redis. | `bool` | `false` | no |
| secondary\_redis\_modules | Redis modules for secondary Managed Redis. Only RediSearch and RedisJSON are allowed with geo-replication. | <pre>list(object({<br>    name = string<br>    args = optional(string)<br>  }))</pre> | `[]` | no |
| secondary\_resource\_group\_name | Resource group name for secondary Managed Redis. | `string` | `null` | no |
| secondary\_resource\_position\_prefix | Position prefix for secondary Managed Redis name. | `bool` | `true` | no |
| secondary\_sku\_name | SKU name for secondary Managed Redis. Balanced\_B3 or higher is required for geo-replication. | `string` | `"Balanced_B3"` | no |
| secondary\_timeouts | Timeouts for the secondary Managed Redis resource. | <pre>object({<br>    create = optional(string)<br>    read   = optional(string)<br>    update = optional(string)<br>    delete = optional(string)<br>  })</pre> | `null` | no |
| sku\_name | Managed Redis SKU. Possible values: Balanced\_B0, Balanced\_B1, Balanced\_B3, Balanced\_B5, Balanced\_B10, Balanced\_B20, Balanced\_B50, Balanced\_B100, Balanced\_B150, Balanced\_B250, Balanced\_B350, Balanced\_B500, Balanced\_B700, Balanced\_B1000, ComputeOptimized\_X3/X5/X10/X20/X50/X100/X150/X250/X350/X500/X700, FlashOptimized\_A250/A500/A700/A1000/A1500/A2000/A4500, MemoryOptimized\_M10/M20/M50/M100/M150/M250/M350/M500/M700/M1000/M1500/M2000. Balanced\_B3 or higher is required for geo-replication. | `string` | `"Balanced_B1"` | no |
| storage\_account\_id | Storage account ID for diagnostic settings destination. | `string` | `null` | no |
| subnet\_id | Subnet ID for the private endpoint. | `string` | `null` | no |
| timeouts | Timeouts for the primary Managed Redis resource (create/read/update/delete). | <pre>object({<br>    create = optional(string)<br>    read   = optional(string)<br>    update = optional(string)<br>    delete = optional(string)<br>  })</pre> | `null` | no |
| user\_object\_id | Object ID of the Azure AD user, group, service principal, or managed identity for access policy assignment. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| database\_id | The ID of the Managed Redis default database |
| default\_database | The full default\_database block of the Managed Redis instance |
| geo\_replication\_group\_name | Geo-replication group name applied to the Managed Redis databases |
| geo\_replication\_id | The ID of the Managed Redis Geo-Replication resource |
| high\_availability\_enabled | Whether high availability is enabled |
| hostname | DNS name of the Managed Redis cluster endpoint |
| id | The ID of the Managed Redis instance |
| linked\_managed\_redis\_ids | Managed Redis IDs linked in the geo-replication group |
| location | The Azure Region of the Managed Redis instance |
| name | The name of the Managed Redis instance |
| port | TCP port of the Managed Redis default database endpoint |
| primary\_access\_key | The primary access key for the Managed Redis default database (exported when access\_keys\_authentication\_enabled is true) |
| public\_network\_access | Public network access setting (Enabled or Disabled) |
| redis\_modules | Redis modules configured on the default database, including computed version |
| resource\_group\_name | The Resource Group of the Managed Redis instance |
| secondary\_access\_key | The secondary access key for the Managed Redis default database (exported when access\_keys\_authentication\_enabled is true) |
| secondary\_database\_id | The ID of the secondary Managed Redis default database |
| secondary\_hostname | The hostname of the secondary Managed Redis instance |
| secondary\_id | The ID of the secondary Managed Redis instance |
| secondary\_name | The name of the secondary Managed Redis instance |
| secondary\_port | TCP port of the secondary Managed Redis default database |
| secondary\_primary\_access\_key | Primary access key for the secondary Managed Redis default database |
| secondary\_redis\_modules | Redis modules on the secondary Managed Redis default database, including computed version |
| secondary\_secondary\_access\_key | Secondary access key for the secondary Managed Redis default database |
| sku\_name | The SKU name of the Managed Redis instance |

