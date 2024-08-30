

variable "instance_name" {
  description = "(Required) The name which should be used for this Mysql Flexible Server. Changing this forces a new Mysql Flexible Server to be created."

}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the MySql Flexible Server should exist. Changing this forces a new Mysql Flexible Server to be created."
}


variable "location" {
  description = "(Required) The Azure Region where the MySQL Flexible Server should exist. Changing this forces a new mySQL Flexible Server to be created."
  default     = "West Europe"
}

variable "admin_login" {
  description = "MySQL administrator login. Required when create_mode is Default."
  type        = string
  default     = null
}

variable "admin_password" {
  description = "MySQL administrator password. If not set, randomly generated"
  type        = string
  default     = null
}
variable "engine_version" {
  description = "(Optional) The version of MySQL Flexible Server to use"
  validation {
    condition     = var.engine_version != "5.7" && var.engine_version != "8.0.21"
    error_message = "Possible version values are 5.7, and 8.0.21"
  }
  type = string
}

variable "sku" {
  description = "The SKU Name for the MySQL Flexible Server."
  type        = string
}
variable "backup_retention_days" {
  description = "The backup retention days for the MySQL Flexible Server"
  validation {
    condition     = var.backup_retention_days < 6 || var.backup_retention_days > 35
    error_message = "backup retention days value should be between 7 and 35 days"
  }
}
variable "subnet_id" {
  description = "The ID of the virtual network subnet to create the mySQL Flexible Server. (Should not have any resource deployed in)"
  type        = string
  default     = null
}
variable "geo_redundant_backup_enabled" {
  description = "Is Geo-Redundant backup enabled on the mysql Flexible Server. "
  default     = false
}
variable "zone" {
  description = "availability zone"
}
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
}
variable "databases" {
  description = "Map of databases configurations"
  type = map(object({
    charset   = optional(string, "UTF8")
    collation = optional(string, "en_US.utf8")
  }))
  default = {}
}

variable "storage" {
  description = "Map of the storage configuration"
  type = object({
    auto_grow_enabled  = optional(bool, true)
    size_gb            = optional(number)
    io_scaling_enabled = optional(bool, false)
    iops               = optional(number)
  })
  default = {}
}
variable "mysql_configurations" {
default = {}
}

variable "links" {
  description = "Map of objects for private link with vnet"
  type = map(object({
    name    = string
    vnet_id = string
  }))
  default = {}
}
variable "allowed_cidrs" {
  description = "Map of authorized CIDRs"
  type        = map(string)
  default     = {}
}
