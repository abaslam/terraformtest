variable "location" {
  description = "Azure region"
  default     = "East US"
}

variable "aks_node_count" {
  description = "Number of AKS nodes"
  default     = 2
}

variable "sql_password" {
  description = "Password for Azure SQL Admin"
  default     = "P@ssw0rd123!"
}
