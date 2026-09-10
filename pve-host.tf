resource "proxmox_network_linux_bond" "bond0" {
    provider = proxmox-host

    name = "bond0"
    node_name = "pve"
    slaves = ["eno3", "eno4"]
    autostart = true
    bond_mode = "802.3ad"
    bond_xmit_hash_policy = "layer3+4"
    comment = "Server Uplink"
}

resource "proxmox_network_linux_vlan" "vlan192" {
    provider = proxmox-host

    node_name = "pve"
    name      = "vlan192"
    interface = "bond0"
    vlan      = 192
    autostart = true
    comment     = "Klient"
}

resource "proxmox_network_linux_bond" "Klient" {
    provider = proxmox-host

    node_name = "pve"
    name      = "Klient"
    ports     = ["vlan192"]
    autostart = true
}
