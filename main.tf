##-----------------------------------------------------------------------------
# Standard Tagging Module – Applies standard tags to all resources for traceability
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azurerm"
  version         = "1.0.2"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

##-----------------------------------------------------------------------------
## Key Vault Key - Deploy encryption key for Managed Redis
##-----------------------------------------------------------------------------
resource "azurerm_key_vault_key" "main" {
  depends_on      = [azurerm_role_assignment.identity_assigned]
  count           = var.enable && var.cmk_encryption_enabled ? 1 : 0
  name            = var.resource_position_prefix ? format("cmk-key-amr-%s", local.name) : format("%s-cmk-key-amr", local.name)
  key_vault_id    = var.key_vault_id
  key_type        = var.key_type
  key_size        = var.key_size
  expiration_date = var.key_expiration_date
  key_opts        = var.key_permissions
  dynamic "rotation_policy" {
    for_each = var.rotation_policy_config.enabled ? [1] : []
    content {
      automatic {
        time_before_expiry = var.rotation_policy_config.time_before_expiry
      }
      expire_after         = var.rotation_policy_config.expire_after
      notify_before_expiry = var.rotation_policy_config.notify_before_expiry
    }
  }
}

##-----------------------------------------------------------------------------
## Key Vault Key - Dedicated encryption key for secondary Managed Redis
##-----------------------------------------------------------------------------
resource "azurerm_key_vault_key" "secondary_cmk_key" {
  depends_on      = [azurerm_role_assignment.identity_assigned]
  count           = var.enable && var.secondary_enabled && var.geo_replication_cmk_enabled ? 1 : 0
  name            = var.secondary_resource_position_prefix ? format("cmk-key-amr-geo-%s", local.name) : format("%s-cmk-key-amr-geo", local.name)
  key_vault_id    = var.key_vault_id
  key_type        = var.key_type
  key_size        = var.key_size
  expiration_date = var.key_expiration_date
  key_opts        = var.key_permissions
  dynamic "rotation_policy" {
    for_each = var.rotation_policy_config.enabled ? [1] : []
    content {
      automatic {
        time_before_expiry = var.rotation_policy_config.time_before_expiry
      }
      expire_after         = var.rotation_policy_config.expire_after
      notify_before_expiry = var.rotation_policy_config.notify_before_expiry
    }
  }
}

##-----------------------------------------------------------------------------
## Azure Managed Redis - Main Redis instance configuration
##-----------------------------------------------------------------------------
resource "azurerm_managed_redis" "main" {
  count                     = var.enable ? 1 : 0
  depends_on                = [azurerm_key_vault_key.main]
  name                      = var.resource_position_prefix ? format("amr-%s", local.name) : format("%s-amr", local.name)
  location                  = var.location
  resource_group_name       = var.resource_group_name
  sku_name                  = var.sku_name
  high_availability_enabled = var.high_availability_enabled
  public_network_access     = var.public_network_access_enabled ? "Enabled" : "Disabled"
  tags                      = module.labels.tags
  default_database {
    access_keys_authentication_enabled            = var.access_keys_authentication_enabled
    client_protocol                               = var.client_protocol
    clustering_policy                             = var.clustering_policy
    eviction_policy                               = var.eviction_policy
    geo_replication_group_name                    = var.geo_replication_group_name
    persistence_append_only_file_backup_frequency = var.geo_replication_group_name != null ? null : var.persistence_aof_backup_frequency
    persistence_redis_database_backup_frequency   = var.geo_replication_group_name != null ? null : var.persistence_rdb_backup_frequency
    dynamic "module" {
      for_each = var.redis_modules
      content {
        name = module.value.name
        args = module.value.args
      }
    }
  }
  identity {
    type         = var.identity_ids != null || var.cmk_encryption_enabled ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.cmk_encryption_enabled ? [azurerm_user_assigned_identity.identity[0].id] : var.identity_ids
  }
  dynamic "customer_managed_key" {
    for_each = var.cmk_encryption_enabled ? [1] : []
    content {
      key_vault_key_id          = azurerm_key_vault_key.main[0].id
      user_assigned_identity_id = azurerm_user_assigned_identity.identity[0].id
    }
  }
  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}

##-----------------------------------------------------------------------------
## Azure Managed Redis - Secondary (geo-replication peer)
##-----------------------------------------------------------------------------
resource "azurerm_managed_redis" "secondary" {
  count                     = var.enable && var.secondary_enabled ? 1 : 0
  depends_on                = [azurerm_key_vault_key.secondary_cmk_key]
  name                      = var.secondary_resource_position_prefix ? format("geo-amr-%s", local.name) : format("%s-geo-amr", local.name)
  location                  = var.secondary_location
  resource_group_name       = var.secondary_resource_group_name
  sku_name                  = var.secondary_sku_name
  high_availability_enabled = var.secondary_high_availability_enabled
  public_network_access     = var.secondary_public_network_access_enabled ? "Enabled" : "Disabled"
  tags                      = module.labels.tags
  default_database {
    access_keys_authentication_enabled = var.secondary_access_keys_authentication_enabled
    client_protocol                    = var.secondary_client_protocol
    clustering_policy                  = var.secondary_clustering_policy
    eviction_policy                    = var.secondary_eviction_policy
    geo_replication_group_name         = var.geo_replication_group_name
    dynamic "module" {
      for_each = var.secondary_redis_modules
      content {
        name = module.value.name
        args = module.value.args
      }
    }
  }
  identity {
    type         = var.secondary_identity_ids != null || (var.cmk_encryption_enabled && var.geo_replication_cmk_enabled) ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = (var.cmk_encryption_enabled && var.geo_replication_cmk_enabled) ? [azurerm_user_assigned_identity.secondary_identity[0].id] : var.secondary_identity_ids
  }
  dynamic "customer_managed_key" {
    for_each = (var.cmk_encryption_enabled && var.geo_replication_cmk_enabled) ? [1] : []
    content {
      key_vault_key_id          = azurerm_key_vault_key.secondary_cmk_key[0].id
      user_assigned_identity_id = azurerm_user_assigned_identity.secondary_identity[0].id
    }
  }
  dynamic "timeouts" {
    for_each = var.secondary_timeouts != null ? [var.secondary_timeouts] : []
    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}

##-----------------------------------------------------------------------------
## Managed Redis Geo-Replication - Link primary and secondary / additional peers
##-----------------------------------------------------------------------------
resource "azurerm_managed_redis_geo_replication" "main" {
  count            = var.enable && (var.secondary_enabled || length(var.linked_managed_redis_ids) > 0) ? 1 : 0
  managed_redis_id = azurerm_managed_redis.main[0].id
  linked_managed_redis_ids = concat(
    var.secondary_enabled ? [azurerm_managed_redis.secondary[0].id] : [],
    var.linked_managed_redis_ids
  )
  dynamic "timeouts" {
    for_each = var.geo_replication_timeouts != null ? [var.geo_replication_timeouts] : []
    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}

##-----------------------------------------------------------------------------
## Private Endpoint - Deploy private network access to Managed Redis
##-----------------------------------------------------------------------------
resource "azurerm_private_endpoint" "pep" {
  count               = var.enable && var.enable_private_endpoint ? 1 : 0
  name                = var.resource_position_prefix ? format("pe-%s", azurerm_managed_redis.main[0].name) : format("%s-pe", azurerm_managed_redis.main[0].name)
  location            = var.private_endpoint_location == null ? var.location : var.private_endpoint_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id == null ? var.subnet_id : var.private_endpoint_subnet_id
  tags                = module.labels.tags
  private_dns_zone_group {
    name                 = var.resource_position_prefix ? format("dns-zone-group-%s", azurerm_managed_redis.main[0].name) : format("%s-dns-zone-group", azurerm_managed_redis.main[0].name)
    private_dns_zone_ids = [var.private_dns_zone_ids]
  }
  private_service_connection {
    name                           = var.resource_position_prefix ? format("psc-%s", azurerm_managed_redis.main[0].name) : format("%s-psc", azurerm_managed_redis.main[0].name)
    is_manual_connection           = false
    private_connection_resource_id = azurerm_managed_redis.main[0].id
    subresource_names              = ["redisEnterprise"]
  }
}

##-----------------------------------------------------------------------------
## Diagnostic Setting - Deploy monitoring and logging for Managed Redis
##-----------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "diag" {
  count                      = var.enable && var.enable_diagnostic ? 1 : 0
  name                       = var.resource_position_prefix ? format("diag-log-%s", azurerm_managed_redis.main[0].name) : format("%s-diag-log", azurerm_managed_redis.main[0].name)
  target_resource_id         = azurerm_managed_redis.main[0].id
  storage_account_id         = var.storage_account_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  dynamic "enabled_log" {
    for_each = var.logs
    content {
      category_group = lookup(enabled_log.value, "category_group", null)
      category       = lookup(enabled_log.value, "category", null)
    }
  }
  dynamic "enabled_metric" {
    for_each = var.metric_enabled ? ["AllMetrics"] : []
    content {
      category = enabled_metric.value
    }
  }
}