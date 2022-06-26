## Azure config variables ##
variable location {
  default = "westus"
}

## Resource group variables ##
variable resource_group_name {
  default = "aksdemo-rg"
}


## AKS kubernetes cluster variables ##
variable cluster_name {
  default = "aksdemo1"
}

variable "agent_count" {
  default = 1
}

variable "dns_prefix" {
  default = "aksdemo"
}

variable "admin_username" {
    default = "demo"
}