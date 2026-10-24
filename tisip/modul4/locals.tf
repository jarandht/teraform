locals {
  name_prefix         = "${var.kortnavn}-${var.project}"
  resource_group_name = "rg-${local.name_prefix}"
}