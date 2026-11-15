variable "rg_name" { type = string }
variable "location" { type = string }
variable "address_space" { type = list(string) }
variable "address_prefix" { type = list(string) }

variable "project" {
  type        = string
  description = "Prefiks i ressursnavnene, f.eks. tim84-iac."

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.project))
    error_message = "project kan bare inneholde små bokstaver, tall og bindestrek (3–20 tegn)."
  }
}

variable "ssh_source_prefix" {
  type        = string
  description = "Hvor SSH (port 22) er tillatt fra. Aldri \"*\"."
  default     = "VirtualNetwork" # Azure-tag: bare trafikk fra eget VNet
}