variable "location" {
  type    = string
  default = "norwayeast"
}

#variable "pipeline_principal_id" {
#  description = "OBJECT-ID til service principal-en, ikke client-ID. Se seksjon 10."
#  type        = string
#}

locals {
  kortnavn = "jht05"
  tags = {
    student = "local.kortnanv"
    course  = "iac"
    keep    = "true"
  }
}