resource "helm_release" "cloudflare" {
    chart = "cloudflare-tunnel-operator"
    name = "cf-operator"
    repository = "https://charts.beezlabs.app"
    version = "0.1.0"
    namespace = "cloudflare"
    depends_on = [ kubernetes_namespace_v1.cloudflare ]
}

resource "kubernetes_namespace_v1" "cloudflare" {
  metadata {
    annotations = {
      "meta.helm.sh/release-name" = "cf-operator",
      "meta.helm.sh/release-namespace" = "cloudflare"
    }

    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
    }
    
    name = "cloudflare"
  }
}

# helm repo add beezlabs https://charts.beezlabs.app/