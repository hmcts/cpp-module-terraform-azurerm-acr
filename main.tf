data "azurerm_virtual_network" "dns_vnet_details" {
  for_each            = var.dns_vnet_links
  name                = each.key
  resource_group_name = each.value["resource_group_name"]
}

resource "azurerm_resource_group" "acr-resource-grp" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    application  = "Management"
    businessArea = "Crime"
  }
}

resource "azurerm_private_dns_zone" "acr-private-dns" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name

  tags = var.tags
  lifecycle {
    ignore_changes = [tags["created_by"], tags["created_time"]]
  }

  depends_on = [
    azurerm_resource_group.acr-resource-grp
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr-private-dns-link" {
  for_each              = data.azurerm_virtual_network.dns_vnet_details
  name                  = each.key
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = each.value.id

  tags = var.tags
  lifecycle {
    ignore_changes = [tags["created_by"], tags["created_time"]]
  }

  #  depends_on = [
  #    azurerm_private_dns_zone.acr-private-dns
  #  ]
}

resource "azurerm_container_registry" "registry" {
  name = var.acr_name

  location            = var.location
  resource_group_name = var.resource_group_name

  sku           = var.sku
  admin_enabled = var.admin_enabled

  public_network_access_enabled = var.public_network_access_enabled

  network_rule_set {
    default_action = "Deny"
    ip_rule = length(var.ip_allow_list) > 0 ? [
      for ip in var.ip_allow_list : {
        action   = "Allow"
        ip_range = ip
      }
    ] : []
  }

  data_endpoint_enabled = var.data_endpoint_enabled
  
  tags = var.tags
  lifecycle {
    ignore_changes = [tags["created_by"], tags["created_time"]]
  }

  depends_on = [
    azurerm_resource_group.acr-resource-grp
  ]
}

resource "azurerm_private_endpoint" "acr_private_endpoint" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr-private-dns.id]
  }

  private_service_connection {
    name                           = "mytest-privateserviceconnection"
    private_connection_resource_id = azurerm_container_registry.registry.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [tags["created_by"], tags["created_time"]]
  }

  depends_on = [
    azurerm_container_registry.registry
  ]
}
