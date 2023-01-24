variable "name" {}
variable "resource_group_name" {}
variable "location" {}


resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = {
    source = "terraform"
  }
}

resource "azurerm_servicebus_topic" "akstopic" {
  name         = "akstopic"
  namespace_id = azurerm_servicebus_namespace.servicebus.id

  enable_partitioning = true
}


output "name" {
  value = azurerm_servicebus_namespace.servicebus.name
}

output "location" {
  value = azurerm_servicebus_namespace.servicebus.location
}