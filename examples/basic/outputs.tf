output "id" {
  value       = module.redis.id
  description = "The ID of the Managed Redis instance"
}

output "name" {
  value       = module.redis.name
  description = "The name of the Managed Redis instance"
}

output "hostname" {
  value       = module.redis.hostname
  description = "The hostname of the Managed Redis instance"
}

output "sku_name" {
  value       = module.redis.sku_name
  description = "The SKU name of the Managed Redis instance"
}

output "location" {
  value       = module.redis.location
  description = "The Azure Region of the Managed Redis instance"
}

output "resource_group_name" {
  value       = module.redis.resource_group_name
  description = "The Resource Group of the Managed Redis instance"
}

output "high_availability_enabled" {
  value       = module.redis.high_availability_enabled
  description = "Whether high availability is enabled"
}

output "public_network_access" {
  value       = module.redis.public_network_access
  description = "Public network access setting (Enabled or Disabled)"
}

output "database_id" {
  value       = module.redis.database_id
  description = "The ID of the Managed Redis default database"
}

output "port" {
  value       = module.redis.port
  description = "The TCP port of the Managed Redis default database endpoint"
}

output "default_database" {
  value       = module.redis.default_database
  description = "The full default_database block of the Managed Redis instance"
  sensitive   = true
}

output "redis_modules" {
  value       = module.redis.redis_modules
  description = "Redis modules configured on the default database, including computed version"
}

output "primary_access_key" {
  value       = module.redis.primary_access_key
  description = "The primary access key for the Managed Redis default database"
  sensitive   = true
}

output "secondary_access_key" {
  value       = module.redis.secondary_access_key
  description = "The secondary access key for the Managed Redis default database"
  sensitive   = true
}
