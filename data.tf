### ---- DNS ---- ###

data "technitium_zone" "zone" {
    name      = "vm.lan"
}



### ---- NETBOX ---- ###

data "netbox_virtualization_cluster" "pve-cl01" {
  name = "pve-cl01"
}

data "netbox_dcim_site" "dc01" {
  slug = "dc01"
}

data "netbox_dcim_device_role" "prod" {
  slug = "vm_prod"
}