### ---- VM ---- ###

resource "proxmox_vm_qemu" "k3s" {
  count = local.k3s.count

  target_node = "pve"
  clone       = local.vm.ub_template_name
  full_clone  = true

  name = "${local.k3s.name}${count.index + 1}"
  vmid = local.k3s.id_range + count.index + 1

  tags = join(",", concat(
    local.vm.tags,
    local.k3s.tags
  ))

  agent              = 1
  power_state        = "running"
  start_at_node_boot = true

  startup_shutdown {
    order = -1
  }

  vga {
    type = "serial0"
  }

  serial {
    id   = 0
    type = "socket"
  }

  ciuser     = local.vm.user
  cipassword = var.pw
  sshkeys    = local.vm.ssh_key

  ipconfig0 = "ip=${local.k3s.ips[count.index]}/${local.k3s.cidr},gw=${local.k3s.gateway}"

  ciupgrade  = true
  nameserver = local.vm.dns

  cpu {
    cores = local.k3s.cpu
  }

  memory = local.k3s.ram

  scsihw = "virtio-scsi-pci"

  disk {
    type    = "cloudinit"
    storage = "local-zfs"
    slot    = "ide2"
  }

  disk {
    size    = "10G"
    type    = "disk"
    storage = "local-zfs"
    discard = false
    slot    = "scsi0"
  }

  network {
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = false
    link_down = false
    id        = 0
  }
}




### ---- DNS ---- ###

resource "technitium_record" "dns" {
    count       = local.k3s.count
    zone        = data.technitium_zone.zone.name
    name        = "${local.k3s.name}${count.index + 1}.${data.technitium_zone.zone.name}"
    type        = "A"
    value       = local.k3s.ips[count.index]
    overwrite   = false
}



### ---- NETBOX ---- ###

resource "netbox_virtualization_vm" "k3s" {
  count      = local.k3s.count
  cluster_id = data.netbox_virtualization_cluster.pve-cl01.id
  site_id    = data.netbox_dcim_site.dc01.id
  role_id    = data.netbox_dcim_device_role.prod.id

  name = "${local.k3s.name}${count.index + 1}"

  memory = local.k3s.ram
  vcpus  = local.k3s.cpu
}

resource "netbox_virtualization_interface" "k3s_eth0" {
  count = local.k3s.count

  name               = "eth0"
  virtualmachine_id  = netbox_virtualization_vm.k3s[count.index].id
}

resource "netbox_ipam_ip_addresses" "k3s_ip" {
  count = local.k3s.count

  address    = "${local.k3s.ips[count.index]}/${local.k3s.cidr}"
  status     = "active"
  object_id  = netbox_virtualization_interface.k3s_eth0[count.index].id
  object_type = netbox_virtualization_interface.k3s_eth0[count.index].type
}

resource "netbox_virtualization_vm_primary_ip" "k3s_primary_ip" {
  count = local.k3s.count

  primary_ip4_id     = netbox_ipam_ip_addresses.k3s_ip[count.index].id
  virtualmachine_id  = netbox_virtualization_vm.k3s[count.index].id
}