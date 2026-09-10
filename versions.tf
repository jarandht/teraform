terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc10"
    }

    proxmox-host = {
      source = "bpg/proxmox"
      version = "0.112.0"
    }

    technitium = {
      source = "darkhonor/technitium"
    }

    netbox = {
      source  = "smutel/netbox"
      version = "~> 8.0.0"
    }
  }
}