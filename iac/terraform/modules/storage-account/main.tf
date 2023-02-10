resource "azurerm_storage_account" "this" {
  # name must contain only letters or numbers
  name                     = "${var.project}${var.env}20230001"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = merge({ Name = "${var.project}-sa-${var.env}" }, var.tags)
}