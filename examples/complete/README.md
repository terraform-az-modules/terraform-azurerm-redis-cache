<!-- BEGIN_TF_DOCS -->

# Terraform Azure Managed Redis

This directory contains an example usage of the **terraform-azure-managed-redis**. It demonstrates how to use the module with default settings or with custom configurations.

---

## 📋 Requirements

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.10.0 |
| Azurerm   | >= 4.57.0 |

---

## 🔌 Providers

None specified in this example.

---

## 📦 Modules

| Name            | Source                                       | Version |
|-----------------|----------------------------------------------|---------|
| resource_group  | terraform-az-modules/resource-group/azurerm  | 1.0.3   |
| vnet            | terraform-az-modules/vnet/azurerm            | 1.0.3   |
| subnet          | terraform-az-modules/subnet/azurerm          | 1.0.3   |
| log-analytics   | terraform-az-modules/log-analytics/azurerm   | 2.1.0   |
| vault           | terraform-az-modules/key-vault/azurerm       | 3.2.0   |
| private_dns_zone| terraform-az-modules/private-dns/azurerm     | 1.0.8   |
| redis           | ../../                                       | n/a     |


---

## 🏗️ Resources

No resources are directly created in this example.

---

## 🔧 Inputs

No input variables are defined in this example.

---

## 📤 Outputs

| Name                               | Description                                                 |
| ---------------------------------- | ----------------------------------------------------------- |
| `id`                               | The ID of the Managed Redis instance                        |
| `name`                             | The name of the Managed Redis instance                      |
| `hostname`                         | The hostname of the Managed Redis instance                  |
| `sku_name`                         | The SKU name of the Managed Redis instance                  |
| `location`                         | The Azure Region of the Managed Redis instance              |
| `resource_group_name`              | The Resource Group of the Managed Redis instance            |
| `high_availability_enabled`        | Whether high availability is enabled                        |
| `public_network_access`            | Public network access setting (Enabled or Disabled)         |
| `database_id`                      | The ID of the Managed Redis default database                |
| `port`                             | The TCP port of the Managed Redis default database endpoint |
| `default_database`                 | The full default_database block of the Managed Redis instance |
| `redis_modules`                    | Redis modules configured on the default database            |
| `primary_access_key`               | The primary access key for the Managed Redis default database |
| `secondary_access_key`             | The secondary access key for the Managed Redis default database |


<!-- END_TF_DOCS -->
