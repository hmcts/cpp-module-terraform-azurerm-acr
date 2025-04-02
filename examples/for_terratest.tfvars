# common
resource_group_name = "rg-lab-cpp-acr-terratest"
vnet_name           = "vnet-lab-cpp-acrterratest"

#tags
namespace   = "cpp"
costcode    = "terratest"
attribute   = ""
owner       = "EI"
environment = "nonlive"
application = "test"

location       = "UK South"
location_short = "uksouth"
platform       = "nlv"


# #private DNS
private_dns_zone_name = "terratest.privatelink.azurecr.io"
private_endpoint_name = "pe-lab-cpp-acrterratest"

# Registry
public_network_access_enabled = false
acr_name                      = "ACRTERRAREPO01"
data_endpoint_enabled         = false
admin_enabled                 = false
# module code always creates network rules, they only work with premium SKU
sku = "Premium"


