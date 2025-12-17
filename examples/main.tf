terraform {
  required_version = ">= 1.14.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 3.0.0"
    }
    vcfa = {
      source = "vmware/vcfa"
      version = ">= 1.0.0"
    }
  }
}

provider "vcfa" {
  url                  = var.vcfa_url
  org                  = var.vcfa_organization
  api_token            = var.vcfa_refresh_token
  allow_unverified_ssl = var.insecure
  auth_type            = "api_token"
}

data "vcfa_kubeconfig" "kubeconfig" {}

provider "kubernetes" {
  host     = data.vcfa_kubeconfig.kubeconfig.host
  insecure = data.vcfa_kubeconfig.kubeconfig.insecure_skip_tls_verify
  token    = data.vcfa_kubeconfig.kubeconfig.token
}

module "projects" {
  source = "../"


  project_name = var.project_name
  description  = var.description
}

