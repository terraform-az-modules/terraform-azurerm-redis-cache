##-----------------------------------------------------------------------------
## Azure Managed Redis
##-----------------------------------------------------------------------------
output "id" {
  value       = try(azurerm_managed_redis.main[0].id, null)
  description = "The ID of the Managed Redis instance"
}

output "name" {
  value       = try(azurerm_managed_redis.main[0].name, null)
  description = "The name of the Managed Redis instance"
}

output "hostname" {
  value       = try(azurerm_managed_redis.main[0].hostname, null)
  description = "DNS name of the Managed Redis cluster endpoint"
}

output "sku_name" {
  value       = try(azurerm_managed_redis.main[0].sku_name, null)
  description = "The SKU name of the Managed Redis instance"
}

output "location" {
  value       = try(azurerm_managed_redis.main[0].location, null)
  description = "The Azure Region of the Managed Redis instance"
}

output "resource_group_name" {
  value       = try(azurerm_managed_redis.main[0].resource_group_name, null)
  description = "The Resource Group of the Managed Redis instance"
}

output "high_availability_enabled" {
  value       = try(azurerm_managed_redis.main[0].high_availability_enabled, null)
  description = "Whether high availability is enabled"
}

output "public_network_access" {
  value       = try(azurerm_managed_redis.main[0].public_network_access, null)
  description = "Public network access setting (Enabled or Disabled)"
}

##-----------------------------------------------------------------------------
## Default Database
##-----------------------------------------------------------------------------
output "database_id" {
  value       = try(azurerm_managed_redis.main[0].default_database[0].id, null)
  description = "The ID of the Managed Redis default database"
}

output "port" {
  value       = try(azurerm_managed_redis.main[0].default_database[0].port, null)
  description = "TCP port of the Managed Redis default database endpoint"
}

output "default_database" {
  value       = try(azurerm_managed_redis.main[0].default_database, null)
  description = "The full default_database block of the Managed Redis instance"
  sensitive   = true
}

output "redis_modules" {
  value       = try(azurerm_managed_redis.main[0].default_database[0].module, [])
  description = "Redis modules configured on the default database, including computed version"
}

##-----------------------------------------------------------------------------
## Access Keys
##-----------------------------------------------------------------------------
output "primary_access_key" {
  value       = try(azurerm_managed_redis.main[0].default_database[0].primary_access_key, null)
  description = "The primary access key for the Managed Redis default database (exported when access_keys_authentication_enabled is true)"
  sensitive   = true
}

output "secondary_access_key" {
  value       = try(azurerm_managed_redis.main[0].default_database[0].secondary_access_key, null)
  description = "The secondary access key for the Managed Redis default database (exported when access_keys_authentication_enabled is true)"
  sensitive   = true
}

##-----------------------------------------------------------------------------
## Geo-Replication
##-----------------------------------------------------------------------------
output "geo_replication_id" {
  value       = try(azurerm_managed_redis_geo_replication.main[0].id, null)
  description = "The ID of the Managed Redis Geo-Replication resource"
}

output "geo_replication_group_name" {
  value       = var.geo_replication_group_name
  description = "Geo-replication group name applied to the Managed Redis databases"
}

output "linked_managed_redis_ids" {
  value       = try(azurerm_managed_redis_geo_replication.main[0].linked_managed_redis_ids, [])
  description = "Managed Redis IDs linked in the geo-replication group"
}

##-----------------------------------------------------------------------------
## Secondary Managed Redis
##-----------------------------------------------------------------------------
output "secondary_id" {
  value       = try(azurerm_managed_redis.secondary[0].id, null)
  description = "The ID of the secondary Managed Redis instance"
}

output "secondary_name" {
  value       = try(azurerm_managed_redis.secondary[0].name, null)
  description = "The name of the secondary Managed Redis instance"
}

output "secondary_hostname" {
  value       = try(azurerm_managed_redis.secondary[0].hostname, null)
  description = "The hostname of the secondary Managed Redis instance"
}

output "secondary_port" {
  value       = try(azurerm_managed_redis.secondary[0].default_database[0].port, null)
  description = "TCP port of the secondary Managed Redis default database"
}

output "secondary_database_id" {
  value       = try(azurerm_managed_redis.secondary[0].default_database[0].id, null)
  description = "The ID of the secondary Managed Redis default database"
}

output "secondary_primary_access_key" {
  value       = try(azurerm_managed_redis.secondary[0].default_database[0].primary_access_key, null)
  description = "Primary access key for the secondary Managed Redis default database"
  sensitive   = true
}

output "secondary_secondary_access_key" {
  value       = try(azurerm_managed_redis.secondary[0].default_database[0].secondary_access_key, null)
  description = "Secondary access key for the secondary Managed Redis default database"
  sensitive   = true
}

output "secondary_redis_modules" {
  value       = try(azurerm_managed_redis.secondary[0].default_database[0].module, [])
  description = "Redis modules on the secondary Managed Redis default database, including computed version"
}
