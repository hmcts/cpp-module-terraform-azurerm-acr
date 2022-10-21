module "acr_subnet" {
  #source                                                = "git::ssh://coderepo.mdv.cpp.nonlive:29418/tf_module.terraform-azurerm-subnet?ref=master"
  source                                                = "git::https://github.com/hmcts/cpp-module-terraform-azurerm-subnet.git?ref=main"
  subnet_name                                           = "SN-LAB-ACR-01"
  core_resource_group_name                              = "RG-LAB-INT-01"
  virtual_network_name                                  = "VN-LAB-INT-01"
  subnet_address_prefixes                               = ["10.1.12.0/28"]
  route_table_name                                      = "default"
  subnet_enforce_private_link_endpoint_network_policies = "true"
}

module "acr" {
  source                        = "../"
  acr_name                      = "ACRTERRAREPO01"
  location                      = "UK South"
  location_short                = "uksouth"
  resource_group_name           = "RG-LAB-ACR-01"
  virtual_network_name          = "VN-LAB-INT-01"
  subnet_id                     = module.acr_subnet.id
  private_endpoint_name         = "Terra-private-endpoint"
  private_dns_zone_name         = "privatelink.azurecr-terra.io"
  core_resource_group_name      = "RG-LAB-INT-01"
  public_network_access_enabled = "false"
  sku                           = "Premium"
}

  
