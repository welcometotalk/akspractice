variable "resource_group_name" {}
variable "location" {}
variable "dns_prefix" {}
variable "cluster_name" {}
variable "create_group" { default = false }
variable "servicebus_name" {}

module "rg" {
  source       = "./modules/resourcegroup"
  name         = var.resource_group_name
  location     = var.location
  create_group = var.create_group
}

module "aks" {
  source              = "./modules/aks"
  name                = var.cluster_name
  dns_prefix          = var.dns_prefix
  resource_group_name = var.resource_group_name
}

module "servicebus" {
  source              = "./modules/servicebus"
  name                = var.servicebus_name
  location          = var.location
  resource_group_name = var.resource_group_name
}


output "resource_group_name" {
  value = module.rg.name
}

output "kubernetes_cluster_name" {
  value = module.aks.name
}