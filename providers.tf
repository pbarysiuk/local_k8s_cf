terraform {
  required_providers {
    k3d = {
      source  = "pvotal-tech/k3d"
      version = "0.0.7"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.12.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.27.0"
    }
  }
}

provider "local" {
}

provider "k3d" {
}

provider "helm" {
  kubernetes {
    config_path = "./k3d_kubeconfig"
  }
}

provider "kubernetes" {
  config_path = "./k3d_kubeconfig"
}