resource_group_name = "rg-its-sls-dev-wu-1"
resource_group_location = "westus"
tags = {
  "cost_center" = "1234H"
  "PHI" = "True"
}
vnet_address_space = ["10.0.0.0/27"]
subnet_prefixes = ["10.0.0.0/29", "10.0.0.8/29", "10.0.0.16/29", "10.0.0.24/29"]
vnet_name     = "vnet-its-sls-dev-wu-1"
subnet_names  = ["snet-its-sls-dev-wu-1", "snet-its-sls-dev-wu-2", "snet-its-sls-dev-wu-3", "snet-its-sls-dev-wu-4"]

