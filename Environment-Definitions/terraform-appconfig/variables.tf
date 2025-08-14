# Variable definitions
variable "name" {
  description = "Specifies the name of the App Configuration store."
  type        = string
  default     = "plt-eng-appconfig-01"
}

variable "location" {
  description = "Specifies the Azure location where the app configuration store should be created."
  type        = string
  default     = "eastus2"
}

variable "key_value_names" {
  description = "Specifies the names of the key-value resources. The name is a combination of key and label with $ as delimiter. The label is optional."
  type        = list(string)
  default     = [
    "key1",
    "key1$label1"
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
  default     = "application/vnd.microsoft.appconfig.keyvaultref+json;charset=utf-8"
}

variable "tags" {
  description = "Adds tags for the key-value resources. It's optional"
  type        = map(string)
  default     = {
    tag1 = "tag-value-1"
    tag2 = "tag-value-2"
  }
}