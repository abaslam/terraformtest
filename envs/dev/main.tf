# Resource Group
module "resource_group" {
  source = "../../modules/resource_group"

  name     = "rg-secure-env"
  location = var.location
}

# Virtual Network
module "vnet" {
  source              = "../../modules/vnet"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_name           = "vnet-secure"
  address_space       = ["10.0.0.0/16"]
  subnet_name         = "subnet-aks"
  subnet_prefixes     = ["10.0.1.0/24"]
}

# AKS Cluster
module "aks" {
  source              = "../../modules/aks"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  aks_name            = "aks-cluster"
  subnet_id           = module.vnet.subnet_id
  node_count          = var.aks_node_count
}

# Azure SQL
module "sql" {
  source              = "../../modules/sql"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.vnet.subnet_id
  sql_server_name     = "sqlserversecure"
  sql_admin_user      = "sqladmin"
  sql_admin_password  = var.sql_password
  database_name       = "securedb"
  aks_identity_id     = module.aks.identity_principal_id
}
