resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password

  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "sql_db" {
  name      = var.database_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "S0"
}

resource "azurerm_private_endpoint" "sql_pe" {
  name                = "sql-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    is_manual_connection           = true
    name                           = "sql-connection"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
  }
}

resource "azurerm_role_assignment" "sql_role" {
  principal_id   = var.aks_identity_id
  role_definition_name = "Contributor"
  scope          = azurerm_mssql_server.sql_server.id
}

output "sql_server_name" {
  value = azurerm_mssql_server.sql_server.name
}