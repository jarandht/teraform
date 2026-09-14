provider "proxmox" {
    pm_api_url          = "https://192.168.192.125:8006/api2/json"
    pm_api_token_id     = "teraform@pam!teraform"
    pm_api_token_secret = ""
    pm_tls_insecure     = true
}

provider "proxmox-host" {
  endpoint = "https://192.168.192.125:8006/"
  username = "root@pam"
  password = ""
  insecure = true

  ssh {
    agent = true
  }
}

provider "technitium" {
  server_url        = "https://192.168.192.122:4443"
  api_token         = "8680cd50e4808a1215890d42104a5dec0092b02e324853db0cf54b809ac4f19f"
  skip_tls_verify   = true
}

provider "netbox" {
  url     = "netbox.local.jarand.site"
  token  = ""
}

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