data "azurerm_subscription" "current" {}

locals {
  tags = {
    application  = "terratest"
    businessArea = "Crime"
  }
}

module "registry" {
  source                        = "../"
  acr_name                      = var.acr_name
  sku                           = var.sku
  location                      = var.location
  location_short                = var.location_short
  private_dns_zone_name         = var.private_dns_zone_name
  private_endpoint_name         = var.private_endpoint_name
  resource_group_name           = var.resource_group_name
  admin_enabled                 = false
  public_network_access_enabled = var.public_network_access_enabled
  #data_endpoint_enabled         = var.data_endpoint_enabled
  subnet_id = azurerm_subnet.test.id
  tags      = local.tags
}


resource "azurerm_virtual_network" "test" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  tags                = local.tags
}

resource "azurerm_subnet" "test" {
  name                                          = "example-subnet"
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.test.name
  address_prefixes                              = ["10.0.1.0/24"]
  private_link_service_network_policies_enabled = false
  private_endpoint_network_policies             = "Enabled"
}
