variable "resource_group_name" {}
variable "cluster_name" {}
variable "namespace" { default = "default" }

resource "kubernetes_namespace" "default" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "demo" {
  metadata {
    name = "demo"
    namespace = kubernetes_namespace.default.metadata.0.name
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "demo"
      }
    }

    template {
      metadata {
        labels = {
          app = "demo"
        }
      }

      spec {
        container {
          name  = "hello-kubernetes-basic"
          image = "paulbouwer/hello-kubernetes:1.10"

          port {
            container_port = 8080
          }

          env {
            name = "KUBERNETES_NAMESPACE"

            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }

          env {
            name = "KUBERNETES_NODE_NAME"

            value_from {
              field_ref {
                field_path = "spec.nodeName"
              }
            }
          }

          resources {
            limits = {
              cpu    = "250m"
              memory = "128Mi"
            }

            requests = {
              cpu    = "80m"
              memory = "64Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "demo" {
  metadata {
    name = "demo"
    namespace = kubernetes_namespace.default.metadata.0.name
  }

  spec {
    port {
      port        = 80
      target_port = "8080"
    }

    selector = {
      app = kubernetes_deployment.demo.spec[0].template[0].metadata[0].labels.app
    }

    type = "ClusterIP"
  }
}