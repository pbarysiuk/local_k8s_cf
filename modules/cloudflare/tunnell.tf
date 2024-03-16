resource "kubernetes_secret_v1" "sample_tunnel" {
  metadata {
    name = "pb.work-tunnel"
  }
  data = {
    token = var.cloudflare_token
    accountID = var.cloudflare_account_id 
  }
  type = "Opaque"
}

resource "kubernetes_manifest" "cloudflaretunnel_sample_tunnel" {
  manifest = {
    "apiVersion" = "cloudflare-tunnel-operator.beezlabs.app/v1alpha1"
    "kind" = "CloudflareTunnel"
    "metadata" = {
      "name" = "pb.work-tunnel"
    }
    "spec" = {
      "container" = {
        "args" = [
          "tunnel",
          "--metrics",
          "localhost:9090",
          "--no-autoupdate",
          "--config",
          "/config/config.yaml",
          "run",
        ]
        "command" = [
          "cloudflared",
        ]
        "image" = "cloudflare/cloudflared:latest"
        "imagePullPolicy" = "Always"
      }
      "domain" = "k3s_traefik.pbarysiuk.work"
      "replicas" = 1
      "service" = {
        "name" = "traefik"
        "namespace" = "traefik"
        "port" = 443
        "protocol" = "https"
      }
      "tokenSecretName" = "sample-tunnel"
      "zone" = "pbarysiuk.work"
    }
  }
}