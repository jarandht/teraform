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
    depends_on = [proxmox_network_linux_bond.bond0]
    node_name = "pve"
    name      = "vlan192"
    interface = "bond0"
    vlan      = 192
    autostart = true
    comment     = "Klient"
}

resource "proxmox_network_linux_bridge" "Klient" {
    provider = proxmox-host
    depends_on = [proxmox_network_linux_vlan.vlan192]
    node_name = "pve"
    name      = "Klient"
    ports     = ["vlan192"]
    autostart = true
}

resource "proxmox_virtual_environment_firewall_rules" "inbound" {
  provider = proxmox-host

  node_name = "pve"

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow HTTP"
    dest    = "192.168.192.125"
    dport   = "8006"
    proto   = "tcp"
    log     = "info"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow SSH"
    dest    = "192.168.192.125"
    dport   = "22"
    proto   = "tcp"
    log     = "info"
  }
}

resource "proxmox_virtual_environment_cluster_firewall" "cluster" {
  provider = proxmox-host

  enabled = true
  ebtables       = true
  input_policy   = "DROP"
  output_policy  = "ACCEPT"
  forward_policy = "ACCEPT"
}

resource "proxmox_node_firewall" "pve" {
  provider = proxmox-host

  node_name = "pve"
  enabled   = true
}