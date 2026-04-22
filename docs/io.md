## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_keys\_authentication\_enabled | Enable access key authentication | `bool` | `true` | no |
| access\_policy\_name | Name of the access policy to assign | `string` | `"Data Contributor"` | no |
| capacity | Redis cache size | `number` | `1` | no |
| custom\_name | Override default naming convention | `string` | `null` | no |
| deployment\_mode | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| enable | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| enable\_diagnostic | Enable diagnostic settings for Redis Cache | `bool` | `true` | no |
| enable\_geo\_replication | Enable geo-replication between primary and secondary Redis caches | `bool` | `false` | no |
| enable\_private\_endpoint | Enable private endpoint for Redis Cache. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `"dev"` | no |
| extra\_tags | Variable to pass extra tags. | `map(string)` | `null` | no |
| family | SKU family - C for Basic/Standard, P for Premium | `string` | `"C"` | no |
| firewall\_rules | Firewall IP address ranges | <pre>map(object({<br>    start_ip = string<br>    end_ip   = string<br>  }))</pre> | <pre>{<br>  "access_to_azure": {<br>    "end_ip": "10.0.3.255",<br>    "start_ip": "10.0.3.0"<br>  }<br>}</pre> | no |
| label\_order | The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']. | `list(any)` | <pre>[<br>  "name",<br>  "environment",<br>  "location"<br>]</pre> | no |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `"centralus"` | no |
| log\_analytics\_workspace\_id | Log Analytics Workspace ID for diagnostics. | `string` | `null` | no |
| logs | List of log configurations for diagnostic settings. Each object can specify either category\_group or category. | <pre>list(object({<br>    category_group = optional(string)<br>    category       = optional(string)<br>  }))</pre> | `[]` | no |
| managedby | ManagedBy, eg 'terraform-az-modules'. | `string` | `"terraform-az-modules"` | no |
| metric\_enabled | Boolean flag to specify whether Metrics should be enabled for the Container Registry. Defaults to true. | `bool` | `true` | no |
| minimum\_tls\_version | Minimum TLS version | `string` | `"1.2"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `"core"` | no |
| non\_ssl\_port\_enabled | Enable non-SSL port 6379 | `bool` | `false` | no |
| object\_id\_alias | Alias for the object ID | `string` | `"ServicePrincipal"` | no |
| patch\_schedule | Redis maintenance schedule | <pre>object({<br>    day_of_week    = string<br>    start_hour_utc = number<br>  })</pre> | `null` | no |
| permissions | Permissions for the Redis cache access policy | `string` | `"+@read +@connection"` | no |
| private\_dns\_zone\_ids | The ID of the private DNS zone. | `string` | `null` | no |
| public\_network\_access\_enabled | Allow public network access | `bool` | `false` | no |
| redis\_config | Redis configuration settings | <pre>object({<br>    authentication_enabled                  = bool<br>    maxmemory_reserved                      = number<br>    maxmemory_delta                         = number<br>    data_persistence_authentication_method  = string<br>    maxfragmentationmemory_reserved         = number<br>    maxmemory_policy                        = string<br>    active_directory_authentication_enabled = bool<br>    backup_enabled                          = bool<br>    rdb_backup_frequency                    = number<br>    aof_backup_enabled                      = bool<br>    aof_storage_connection_string_0         = string<br>  })</pre> | <pre>{<br>  "active_directory_authentication_enabled": false,<br>  "aof_backup_enabled": false,<br>  "aof_storage_connection_string_0": null,<br>  "authentication_enabled": true,<br>  "backup_enabled": false,<br>  "data_persistence_authentication_method": "SAS",<br>  "maxfragmentationmemory_reserved": 50,<br>  "maxmemory_delta": 50,<br>  "maxmemory_policy": "allkeys-lru",<br>  "maxmemory_reserved": 50,<br>  "rdb_backup_frequency": 60<br>}</pre> | no |
| redis\_version | Redis version | `string` | `"6"` | no |
| replicas\_per\_master | Number of replicas per master | `number` | `null` | no |
| replicas\_per\_primary | Number of replicas per primary | `number` | `null` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/terraform-az-modules/terraform-azure-redis-cache"` | no |
| resource\_group\_name | The name of the resource group in which to create the Redis Cache. | `string` | n/a | yes |
| resource\_position\_prefix | Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.<br><br>- If true, the keyword is prepended: "vnet-core-dev".<br>- If false, the keyword is appended: "core-dev-vnet".<br><br>This helps maintain naming consistency based on organizational preferences. | `bool` | `true` | no |
| secondary\_access\_keys\_authentication\_enabled | Enable access key authentication for secondary Redis cache | `bool` | `true` | no |
| secondary\_capacity | Capacity for secondary Redis cache | `number` | `1` | no |
| secondary\_enabled | Enable secondary Redis cache | `bool` | `false` | no |
| secondary\_family | SKU family for secondary Redis cache | `string` | `"P"` | no |
| secondary\_location | Location for secondary Redis cache | `string` | `"eastus"` | no |
| secondary\_minimum\_tls\_version | Minimum TLS version for secondary Redis cache | `string` | `"1.2"` | no |
| secondary\_non\_ssl\_port\_enabled | Enable non-SSL port for secondary Redis cache | `bool` | `false` | no |
| secondary\_patch\_schedule | Patch schedule for secondary Redis cache | <pre>object({<br>    day_of_week    = string<br>    start_hour_utc = number<br>  })</pre> | `null` | no |
| secondary\_public\_network\_access\_enabled | Enable public network access for secondary Redis cache | `bool` | `false` | no |
| secondary\_redis\_config | Redis configuration settings for secondary cache | <pre>object({<br>    authentication_enabled                  = bool<br>    maxmemory_reserved                      = number<br>    maxmemory_delta                         = number<br>    data_persistence_authentication_method  = string<br>    maxfragmentationmemory_reserved         = number<br>    maxmemory_policy                        = string<br>    active_directory_authentication_enabled = bool<br>    backup_enabled                          = bool<br>    rdb_backup_frequency                    = number<br>    aof_backup_enabled                      = bool<br>    aof_storage_connection_string_0         = string<br>  })</pre> | <pre>{<br>  "active_directory_authentication_enabled": false,<br>  "aof_backup_enabled": false,<br>  "aof_storage_connection_string_0": null,<br>  "authentication_enabled": true,<br>  "backup_enabled": false,<br>  "data_persistence_authentication_method": "SAS",<br>  "maxfragmentationmemory_reserved": 50,<br>  "maxmemory_delta": 50,<br>  "maxmemory_policy": "allkeys-lru",<br>  "maxmemory_reserved": 50,<br>  "rdb_backup_frequency": 60<br>}</pre> | no |
| secondary\_redis\_version | Redis version for secondary cache | `string` | `"6"` | no |
| secondary\_replicas\_per\_master | Number of replicas per master for secondary Redis cache | `number` | `1` | no |
| secondary\_replicas\_per\_primary | Number of replicas per primary for secondary Redis cache | `number` | `1` | no |
| secondary\_resource\_group\_name | Resource group name for secondary Redis cache | `string` | `null` | no |
| secondary\_resource\_position\_prefix | Position prefix for secondary Redis cache name | `bool` | `true` | no |
| secondary\_sku\_name | SKU name for secondary Redis cache | `string` | `"Premium"` | no |
| server\_role | Role of the linked server - Primary or Secondary | `string` | `"Secondary"` | no |
| sku\_name | Redis SKU - Basic, Standard, or Premium | `string` | `"Standard"` | no |
| storage\_account\_id | Storage account ID for diagnostic settings destination. | `string` | `null` | no |
| subnet\_id | Subnet ID for the private endpoint. | `string` | `null` | no |
| user\_object\_id | Object ID of the user or service principal | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| access\_policy\_id | The ID of the Redis Cache Access Policy |
| firewall\_rule\_ids | Map of Redis Firewall Rule IDs indexed by rule key |
| geo\_replicated\_primary\_host\_name | The geo-replicated primary hostname of the linked server |
| hostname | The hostname of the Redis Cache instance |
| id | The ID of the Redis Cache instance |
| linked\_server\_id | The ID of the Redis Linked Server |
| linked\_server\_name | The name of the Redis Linked Server |
| maxclients | Maximum number of connected clients allowed |
| port | The non-SSL port of the Redis Cache instance |
| primary\_access\_key | The primary access key for the Redis Cache instance |
| primary\_connection\_string | The primary connection string of the Redis Cache instance |
| redis\_configuration | Redis configuration block applied to the cache instance |
| secondary\_access\_key | The secondary access key for the Redis Cache instance |
| secondary\_connection\_string | The secondary connection string of the Redis Cache instance |
| ssl\_port | The SSL port of the Redis Cache instance |

