#  Azure Database for MySQL - Flexible Server
 Use Terraform to deploy an instance of Azure Database for MySQL - Flexible Server and a database in a virtual network.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mysql_flexible_database.instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) | resource |
| [azurerm_mysql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [random_password.mysql_administrator_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_login"></a> [admin\_login](#input\_admin\_login) | MySQL administrator login. Required when create\_mode is Default. | `string` | `null` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | MySQL administrator password. If not set, randomly generated | `string` | `null` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | The backup retention days for the MySQL Flexible Server | `any` | n/a | yes |
| <a name="input_databases"></a> [databases](#input\_databases) | Map of databases configurations | <pre>map(object({<br>    charset   = optional(string, "UTF8")<br>    collation = optional(string, "en_US.utf8")<br>  }))</pre> | `{}` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (Optional) The version of MySQL Flexible Server to use | `string` | n/a | yes |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Is Geo-Redundant backup enabled on the mysql Flexible Server. | `bool` | `false` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | (Required) The name which should be used for this Mysql Flexible Server. Changing this forces a new Mysql Flexible Server to be created. | `any` | n/a | yes |
| <a name="input_links"></a> [links](#input\_links) | Map of objects for private link with vnet | <pre>map(object({<br>    name    = string<br>    vnet_id = string<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the MySQL Flexible Server should exist. Changing this forces a new mySQL Flexible Server to be created. | `string` | `"West Europe"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the MySql Flexible Server should exist. Changing this forces a new Mysql Flexible Server to be created. | `any` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU Name for the MySQL Flexible Server. | `string` | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | Map of the storage configuration | <pre>object({<br>    auto_grow_enabled  = optional(bool, true)<br>    size_gb            = optional(number)<br>    io_scaling_enabled = optional(bool, false)<br>    iops               = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the virtual network subnet to create the mySQL Flexible Server. (Should not have any resource deployed in) | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | availability zone | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Administrator password for MySQL Flexible server. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the PostgreSQL Flexible Server. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the PostgreSQL Flexible Server. |
<!-- END_TF_DOCS -->