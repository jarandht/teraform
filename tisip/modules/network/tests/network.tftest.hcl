mock_provider "azurerm" {}

variables {
  project        = "jht05-iac"
  location       = "norwayeast"
  rg_name        = "jht05-iac-rg"
  address_space  = ["10.0.0.0/16"]
  address_prefix = ["10.0.1.0/24"]
}

run "subnettene_har_riktig_cidr" {
  command = plan

  assert {
    condition     = azurerm_subnet.app.address_prefixes[0] == "10.0.1.0/24"
    error_message = "Subnettet skal ha CIDR 10.0.1.0/24."
  }

}

run "navnene_bruker_prefikset" {
  command = plan

  assert {
    condition     = azurerm_virtual_network.vnet.name == "jht05-iac-vnet"
    error_message = "VNet-navnet skal være <project>-vnet."
  }
}

run "ugyldig_project_avvises" {
  command = plan

  variables {
    project = "Tim84 IAC"
  }

  expect_failures = [var.project]
}

run "ssh_er_ikke_aapent_for_internett" {
  command = plan

  assert {
    condition = alltrue([
      for r in azurerm_network_security_group.this.security_rule :
      r.source_address_prefix != "*" if r.destination_port_range == "22"
    ])
    error_message = "SSH (port 22) skal ikke være åpent fra hele internett."
  }
}