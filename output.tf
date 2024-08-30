output "id" {
  value       = azurerm_mysql_flexible_server.this.id
  description = "The ID of the PostgreSQL Flexible Server."
}

output "fqdn" {
  value       = azurerm_mysql_flexible_server.this.fqdn
  description = "The FQDN of the PostgreSQL Flexible Server."
}

output "admin_password" {
  description = "Administrator password for MySQL Flexible server."
  value       = coalesce(var.admin_password, one(random_password.administrator_password[*].result))
  sensitive   = true
}