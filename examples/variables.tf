variable "location" {
  type    = string
  default = "uksouth"
}
variable "location_short" {
  description = "Short string for Azure location"
  type        = string
  default     = "uksouth"
}
variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be an organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "costcode" {
  type        = string
  description = "Name of theDWP PRJ number (obtained from the project portfolio in TechNow)"
  default     = ""
}

variable "owner" {
  type        = string
  description = "Name of the project or sqaud within the PDU which manages the resource. May be a persons name or email also"
  default     = ""
}


variable "application" {
  type        = string
  description = "Application to which the s3 bucket relates"
  default     = ""
}

variable "attribute" {
  type        = string
  description = "An attribute of the s3 bucket that makes it unique"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment into which resource is deployed"
  default     = ""
}

variable "type" {
  type        = string
  description = "Name of service type"
  default     = ""
}

variable "version_number" {
  type        = string
  description = "The version of the application or object being deployed. This could be a build object or other artefact which is appended by a CI/Cd platform as part of a process of standing up an environment"
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  type        = string
  default     = "rg-lab-cpp-saterratest"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "allowed_subnet_ids" {
  description = "List of subnet IDs allowed to access the storage account."
  type        = list(string)
  default     = []
}

variable "vnet_name" {
  type    = string
  default = ""
}

variable "private_link_service_name" {
  type    = string
  default = ""
}

variable "private_endpoint_name" {
  type    = string
  default = ""
}

variable "private_endpoint_connection_name" {
  type    = string
  default = ""
}

variable "private_dns_zone_name" {
  type    = string
  default = ""
}

variable "blob_soft_delete_retention_days" {
  description = "Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`"
  default     = 7
  type        = number
}

variable "container_soft_delete_retention_days" {
  description = "Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`"
  default     = 7
  type        = number
}


variable "public_network_access_enabled" {
  description = "Whether the public network access is enabled"
  type        = bool
}

variable "acr_name" {
  type    = string
  default = ""
}

variable "data_endpoint_enabled" {
  description = "Whether the public network access is enabled"
  type        = bool
}

variable "sku" {
  description = "The SKU name of the the container registry. Possible values are Classic (which was previously Basic), Basic, Standard and Premium."
  type        = string
  default     = "Standard"
}

variable "postfix" {
  description = "A postfix string to centrally mitigate resource name collisions."
  type        = string
  default     = "42069"
}