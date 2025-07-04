provider "aws" {
  region = var.region
}

module "eks" {
  source     = "./modules/eks"
  cluster_name = var.cluster_name
  region     = var.region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca)
  token                  = module.eks.cluster_token

  
}

# Automatically grant EKS nodes permission to join cluster
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = module.eks.node_group_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = [
          "system:bootstrappers",
          "system:nodes"
        ]
      }
    ])
  }

  depends_on = [module.eks]
}

# Create namespace for the app
resource "kubernetes_namespace" "app" {
  metadata {
    name = "myapp"
  }

  depends_on = [module.eks]
}

# Deploy nginx container
resource "kubernetes_deployment" "app" {
  metadata {
    name      = "myapp"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "myapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "myapp"
        }
      }

      spec {
        container {
          name  = "myapp"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
  depends_on = [module.eks]
}

# Internal-only service (ClusterIP)
resource "kubernetes_service" "app" {
  metadata {
    name      = "myapp-service"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    selector = {
      app = "myapp"
    }

    port {
      port        = 80
      target_port = 80
    }
    
  }
  depends_on = [module.eks]
}