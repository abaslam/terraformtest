output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_name" {
  value = module.vnet.name
}

output "aks_name" {
  value = module.aks.name
}

output "sql_server_name" {
  value = module.sql.sql_server_name
}
