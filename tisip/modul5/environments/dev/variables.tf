variable "location" {
  description = "Azure-region for ressursene"
  type        = string
}

variable "address_prefix" { type = list(string) }
variable "address_space" { type = list(string) }