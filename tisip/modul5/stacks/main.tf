module "name" {
  source         = "../modules/network"
  name_prefix    = var.name_prefix
  location       = var.location
  rg_name        = var.rg_name
  address_prefix = var.address_prefix
  address_space  = var.address_space
}