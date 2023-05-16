terraform {

  backend "local" {
    path = "/tmp/terraform_state/aks_deploy_app1_demo.tfstate"
  }

  required_version = ">=0.12"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig
}