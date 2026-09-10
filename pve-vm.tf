resource "proxmox_vm_qemu" "k3s" {
    count = var.vm_k3s_count

    target_node = "pve"
    clone       = var.vm_template_name
    full_clone  = true

    name = "${var.vm_k3s_name}${count.index + 1}"
    vmid = 200 + count.index + 1
    tags        = join(",", concat(
        var.vm_tags,
        var.vm_k3s_tags
    ))
    agent = 1
    power_state         = "running"
    
    vga {
        type = "serial0"
    }

    serial {
        id = 0
        type = "socket"
    }

    ciuser = "serveradmin"
    cipassword = "serveradmin"
    sshkeys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6smfwCpnu4iEW67/hqaucfpQrYMtNgfKXyJ3ljoJFhoH16ztrtNpmvE1rGQRQului7huWFajWM8qMN71mQdFmc7ef4EHsfW1CBtDYzDjmSJUoGZfyEhMIjrpPNMgWtrC4u2J3McF5eIQ4EbscIusODEqRgRbRXw1MZHOcSpBQXDPL5CawnyJmp7WLKGy9fkZ82V+4SAWbrgD7uI+mTbVMMMo+R1ZKe2aw8w4D89g15EYLywKlFAC/hoiSl/MnomKYk6rfqskTTCm50Y7IK3ZhZ7J8Ytd+rXsU2XPlJmXnh/LEX0fndIqVeAkrG/deQRsZVGdTQDcAK+K3KlL5W3Akv/HemjxxfvUKSAZKVv4kPrfmENmKArLJSQW0vvGFKFK44ep/dO5tFwbB4YlrxJ6xsBTqwu8x9mDGsn/AyqSgMEYlQH6j7K2KMttvNGLbGIGgjQPV1gi4vajSj3y4X+/uQsH+HEbRQufJH68GG18qcBzSTMPxhwMCzJBWrR4myZrFKHRqYGo5BCmsrG7vVTLbrGGstfo2up96f7XzRi9oXIJxJFLHnWAN1vGJuovmuEM/HyHxywF2Tvn12AiPzCTfS4YxVu0XiiQGvWdcSIjqBTkhXf401ttKIgvFFtmpQrOyPivjTl5Mf7vDEPbRrKFDab2KbHEwNxx4jbeme8BSXw== jarand@jarand.site"
    ipconfig0 = "ip=${var.vm_k3s_ips[count.index]}/${var.vm_k3s_ips_cdir},gw=${var.vm_k3s_gateway}"
    ciupgrade = "true"
    nameserver = "10.9.0.10,10.9.0.11"
    
    cpu {
        cores           = var.vm_k3s_cpu
    }

    memory              = var.vm_k3s_ram 

    scsihw = "virtio-scsi-pci"

    disk {
        type            = "cloudinit"
        storage         = "local-zfs"
        slot            = "ide2"
    }

    disk {
        size            = "10G"
        type            = "disk"
        storage         = "local-zfs"
        discard         = false
        slot            = "scsi0"
    }

    network {
        model     = "virtio"
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
        id        = 0
    }
}