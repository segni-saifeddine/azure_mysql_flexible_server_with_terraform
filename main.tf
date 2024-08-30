##############################################################
# This module creates a mysql flexible server
##############################################################

resource "azurerm_mysql_flexible_server" "this" {
  name                         = var.instance_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.admin_login
  administrator_password       = coalesce(var.admin_password, one(random_password.administrator_password[*].result))
  sku_name                     = var.sku
  backup_retention_days        = var.backup_retention_days
  version                      = var.engine_version
  zone                         = var.zone
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  delegated_subnet_id          = var.subnet_id
  dynamic "storage" {
    for_each = toset(var.storage != null ? [var.storage] : [])

    content {
      auto_grow_enabled  = var.storage.auto_grow_enabled
      size_gb            = var.storage.size_gb
      io_scaling_enabled = var.storage.io_scaling_enabled
      iops               = var.storage.iops
    }
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [
      zone,
      high_availability[0].standby_availability_zone,
    ]
    precondition {
      condition     = (var.storage.io_scaling_enabled && var.storage.iops == null) || (!var.storage.io_scaling_enabled && var.storage.iops != null)
      error_message = "You have to choose between enabling storage auto-scaling IO without defining storage IOPS or disabling storage auto-scaling IO with defined storage IOPS."
    }
  }
}

resource "azurerm_mysql_flexible_database" "instance" {
  for_each            = var.databases
  name                = each.key
  server_name         = azurerm_mysql_flexible_server.this.name
  charset             = each.value.charset
  collation           = each.value.collation
  resource_group_name = azurerm_mysql_flexible_server.this.resource_group_name
}

resource "azurerm_mysql_flexible_server_configuration" "this" {
  for_each            = var.mysql_configurations
  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this.name
  value               = each.value
}

resource "azurerm_private_dns_zone" "this" {
  name                = "${var.instance_name}.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each              = var.links
  name                  = each.value.name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = each.value.vnet_id
  resource_group_name   = var.resource_group_name
}

resource "random_password" "mysql_administrator_password" {
  length           = 32
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "firewall_rules" {
  for_each = var.allowed_cidrs

  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this.name
  start_ip_address    = cidrhost(each.value, 0)
  end_ip_address      = cidrhost(each.value, -1)
}