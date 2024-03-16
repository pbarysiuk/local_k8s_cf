resource "helm_release" "traefik" {
    chart = "traefik"
    name = "traefik"
    repository = "https://helm.traefik.io/traefik"
    namespace = "traefik"
    depends_on = [ resource.kubernetes_namespace_v1.traefik ]
}

resource "kubernetes_namespace_v1" "traefik" {
  metadata {
    annotations = {
      "meta.helm.sh/release-name" = "traefik",
      "meta.helm.sh/release-namespace" = "traefik"
    }

    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
    }

    name = "traefik"
  }
}