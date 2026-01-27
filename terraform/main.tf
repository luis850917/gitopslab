terraform {
  required_version = ">= 1.4.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "demo" {
  metadata {
    name = "demo"
  }
}

resource "kubernetes_config_map" "gitops_bridge" {
  metadata {
    name      = "gitops-bridge"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  data = {
    environment  = var.environment
    cluster_name = var.cluster_name
  }
}
