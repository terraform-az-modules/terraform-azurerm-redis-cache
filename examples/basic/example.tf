provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.3"
  name        = "core"
  environment = "dev"
  location    = "centralus"
  label_order = ["name", "environment", "location"]
}

##-----------------------------------------------------------------------------
## Redis module call
##-----------------------------------------------------------------------------
module "redis" {
  source                  = "../../"
  name                    = "core"
  environment             = "dev"
  location                = module.resource_group.resource_group_location
  resource_group_name     = module.resource_group.resource_group_name
  enable_private_endpoint = false
  enable_diagnostic       = false
}
