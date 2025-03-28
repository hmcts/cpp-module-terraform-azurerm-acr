variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}


variable "location" {
  description = "Azure region to use"
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location"
  type        = string
}

# variable "environment" {
#   description = "Project environment"
#   type        = string
# }

# variable "stack" {
#   description = "Project stack name"
#   type        = string
# }

# variable "project_name" {
#   description = "Project name/account used in naming"
#   type        = string
# }

variable "name_prefix" {
  description = "Optional prefix for Azure Container Registry name"
  type        = string
  default     = ""
}

variable "custom_name" {
  description = "Custom Azure Container Registry name, generated if not set"
  type        = string
  default     = ""
}

variable "sku" {
  description = "The SKU name of the the container registry. Possible values are Classic (which was previously Basic), Basic, Standard and Premium."
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to associate with your Azure Container Registry."
  type        = map(string)
  default     = {}
}

variable "georeplication_locations" {
  description = "A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
  default     = null
}

variable "private_dns_zone_name" {
  description = "Name of private DNS"
  type        = string
}

variable "private_endpoint_name" {
  description = "private endpoint name"
  type        = string
}

variable "dns_vnet_links" {
  description = "vnet links to be created for the private zone"
  type        = map(map(any))
  default     = {}
}

variable "subnet_id" {
  description = "The subnet id"
  type        = string
  default     = ""
}

variable "private_end_point_name" {
  description = "The private endpoint name"
  type        = string
  default     = ""
}

variable "acr_name" {
  description = "ACR name"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Public Network Access"
  type        = bool
  default     = false
}

variable "virtual_network_id" {
  description = "The virtual network ID"
  type        = string
  default     = ""
}

variable "ip_allow_list" {
  type    = list(string)
  default = []
}

variable "data_endpoint_enabled" {
  description = "Whether to enable dedicated data endpoints for this Container Registry? This is only supported on resources with the Premium SKU."
  type        = bool
  default     = null
}