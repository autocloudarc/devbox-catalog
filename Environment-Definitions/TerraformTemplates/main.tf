# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Variable definitions
variable "name" {
  description = "Specifies the name of the App Configuration store."
  type        = string
}

variable "location" {
  description = "Specifies the Azure location where the app configuration store should be created."
  type        = string
  default     = "westus3"
}

variable "key_value_names" {
  description = "Specifies the names of the key-value resources. The name is a combination of key and label with $ as delimiter. The label is optional."
  type        = list(string)
  default     = [
    "myKey",
    "myKey$myLabel"
  ]
}

variable "key_value_values" {
  description = "Specifies the values of the key-value resources. It's optional"
  type        = list(string)
  default     = [
    "Key-value without label",
    "Key-value with label"
  ]
}

variable "content_type" {
  description = "Specifies the content type of the key-value resources. For feature flag, the value should be application/vnd.microsoft.appconfig.ff+json;charset=utf-8. For Key Value reference, the value should be application/vnd.microsoft.appconfig.keyvaultref+json;charset=utf-8. Otherwise, it's optional."
  type        = string
  default     = "the-content-type"
}

variable "tags" {
  description = "Adds tags for the key-value resources. It's optional"
  type        = map(string)
  default     = {
    tag1 = "tag-value-1"
    tag2 = "tag-value-2"
  }
}

# Create the App Configuration Store
resource "azurerm_app_configuration" "config_store" {
  name                = var.name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name
  sku                 = "standard"
}

# Data source to get the current resource group
data "azurerm_resource_group" "main" {
  name = "rg-${var.name}"
}

# Create key-value pairs in the App Configuration Store
resource "azurerm_app_configuration_key" "config_store_key_value" {
  count                  = length(var.key_value_names)
  configuration_store_id = azurerm_app_configuration.config_store.id
  key                    = split("$", var.key_value_names[count.index])[0]
  label                  = length(split("$", var.key_value_names[count.index])) > 1 ? split("$", var.key_value_names[count.index])[1] : null
  value                  = var.key_value_values[count.index]
  content_type          = var.content_type
  tags                  = var.tags
}

# Output the first key-value pair's value
output "reference_key_value_value" {
  description = "The value of the first key-value pair"
  value       = azurerm_app_configuration_key.config_store_key_value[0].value
}
