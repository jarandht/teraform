locals {
  vm = {
    ub_template_name = "ubuntu-26-cloud"
    tags = ["Ubuntu-26-Cloud", "Teraform"]
    user = "serveradmin"
    ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6smfwCpnu4iEW67/hqaucfpQrYMtNgfKXyJ3ljoJFhoH16ztrtNpmvE1rGQRQului7huWFajWM8qMN71mQdFmc7ef4EHsfW1CBtDYzDjmSJUoGZfyEhMIjrpPNMgWtrC4u2J3McF5eIQ4EbscIusODEqRgRbRXw1MZHOcSpBQXDPL5CawnyJmp7WLKGy9fkZ82V+4SAWbrgD7uI+mTbVMMMo+R1ZKe2aw8w4D89g15EYLywKlFAC/hoiSl/MnomKYk6rfqskTTCm50Y7IK3ZhZ7J8Ytd+rXsU2XPlJmXnh/LEX0fndIqVeAkrG/deQRsZVGdTQDcAK+K3KlL5W3Akv/HemjxxfvUKSAZKVv4kPrfmENmKArLJSQW0vvGFKFK44ep/dO5tFwbB4YlrxJ6xsBTqwu8x9mDGsn/AyqSgMEYlQH6j7K2KMttvNGLbGIGgjQPV1gi4vajSj3y4X+/uQsH+HEbRQufJH68GG18qcBzSTMPxhwMCzJBWrR4myZrFKHRqYGo5BCmsrG7vVTLbrGGstfo2up96f7XzRi9oXIJxJFLHnWAN1vGJuovmuEM/HyHxywF2Tvn12AiPzCTfS4YxVu0XiiQGvWdcSIjqBTkhXf401ttKIgvFFtmpQrOyPivjTl5Mf7vDEPbRrKFDab2KbHEwNxx4jbeme8BSXw== jarand@jarand.site"
    dns = "10.9.0.10,10.9.0.11"
  }

  k3s = {
    name    = "srv-k3s-0"
    id_range = 200
    count   = 3
    cpu     = 2
    ram     = 4092
    cidr    = 24
    gateway = "192.168.192.1"

    ips = [
      "192.168.192.101",
      "192.168.192.102",
      "192.168.192.103"
    ]

    tags = ["K3S-Worker","Nowel-Cloud"]
  }

  pg = {
    name    = "srv-pg-0"
    id_range = 300
    count   = 3
    cpu     = 2
    ram     = 4092
    cidr    = 24
    gateway = "192.168.192.1"

    ips = [
      "192.168.192.101",
      "192.168.192.102",
      "192.168.192.103"
    ]

    tags = ["pg-Worker","Nowel-Cloud"]
  }
}
