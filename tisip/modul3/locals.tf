locals {
  # Ett felles navnemønster som alle ressursnavn bygges fra
  name_prefix = "${var.kortnavn}-${var.project}"

  resource_group_name = "rg-${local.name_prefix}"
}