output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "acr_name" {
  value = module.registry.ACR_NAME
}

# Value used by terratest check
output "resource_group_name" {
  value = "${var.resource_group_name}${var.postfix}"
}

