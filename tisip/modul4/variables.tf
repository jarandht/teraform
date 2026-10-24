variable "kortnavn" {
  description = "Ditt unike kortnavn. Brukes som prefiks i alle ressursnavn."
  type        = string
}

variable "project" {
  description = "Kort prosjektnavn brukt i ressursnavn"
  type        = string
}

variable "location" {
  description = "Azure-region for ressursene"
  type        = string
}

variable "address_prefix" { type = list(string) }
variable "address_space" { type = list(string) }