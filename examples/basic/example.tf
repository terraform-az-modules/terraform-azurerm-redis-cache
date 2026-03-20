provider "azurerm" {
  features {}
}

module "redis-cache" {
  source = "../../"
}
