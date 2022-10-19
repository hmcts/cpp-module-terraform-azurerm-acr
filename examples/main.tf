resource "azurerm_resource_group" "acr-resource-grp" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "registry" {
  name = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  depends_on = [
    azurerm_resource_group.acr-resource-grp
  ]
}
module "Azure-ACR" {
  source                   = "../../"
  location                 = var.location
  acr_name                 = var.acr_name
  resource_group_name      = var.resource_group_name
  sku                      = var.sku
  admin_enabled            = var.admin_enabled
  depends_on               = [azurerm_resource_group.acr-resource-grp]
}