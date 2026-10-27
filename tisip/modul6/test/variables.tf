variable "name_prefix" { type = string }
variable "location" { 
    type = string 
    default = "norwayeast"    
}
variable "rg_name" { type = string }
variable "address_prefix" { 
    type = list(string) 
    default = ["10.0.0.0/8"] 
}
variable "address_space" { type = list(string) }