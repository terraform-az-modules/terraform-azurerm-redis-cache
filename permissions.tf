##-----------------------------------------------------------------------------
## Permissions, Roles, and Policies
##-----------------------------------------------------------------------------
resource "azurerm_managed_redis_access_policy_assignment" "identity_assigned" {
  count            = var.enable && var.user_object_id != null ? 1 : 0
  managed_redis_id = azurerm_managed_redis.main[count.index].id
  object_id        = var.user_object_id
}

##-------------------------------------------------------------------------------------
## User Assigned Identity - Create user assigned identity in your azure environment.
##-------------------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "identity" {
  count               = var.enable && var.cmk_encryption_enabled ? 1 : 0
  location            = var.location
  name                = var.resource_position_prefix ? format("mid-st-%s", local.name) : format("%s-st-mid", local.name)
  resource_group_name = var.resource_group_name
  tags                = module.labels.tags
}

##-----------------------------------------------------------------------------
## User Assigned Identity - Dedicated identity for secondary (geo) Redis
##-----------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "secondary_identity" {
  count               = var.enable && var.secondary_enabled && var.geo_replication_cmk_enabled ? 1 : 0
  name                = var.secondary_resource_position_prefix ? format("mid-st-geo-%s", local.name) : format("%s-st-mid-geo", local.name)
  resource_group_name = var.secondary_resource_group_name
  location            = var.secondary_location
  tags                = module.labels.tags
}

##-----------------------------------------------------------------------------------------------------------------------
## Below resource will assign 'Key Vault Crypto Service Encryption User' role to user assigned identity created above.
##-----------------------------------------------------------------------------------------------------------------------
resource "azurerm_role_assignment" "identity_assigned" {
  depends_on           = [azurerm_user_assigned_identity.identity]
  count                = var.enable && var.cmk_encryption_enabled && var.key_vault_rbac_auth_enabled ? 1 : 0
  principal_id         = azurerm_user_assigned_identity.identity[0].principal_id
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
}

##-----------------------------------------------------------------------------------------------------------------------
## Below resource will assign 'Key Vault Crypto Service Encryption User' role to secondary user assigned identity.
##-----------------------------------------------------------------------------------------------------------------------
resource "azurerm_role_assignment" "secondary_identity_assigned" {
  depends_on           = [azurerm_user_assigned_identity.secondary_identity]
  count                = var.enable && var.secondary_enabled && var.geo_replication_cmk_enabled && var.key_vault_rbac_auth_enabled ? 1 : 0
  principal_id         = azurerm_user_assigned_identity.secondary_identity[0].principal_id
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
}