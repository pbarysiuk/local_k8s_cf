module "cluster" {
  source = "./modules/cluster"
}

module "cloudflare" {
  source = "./modules/cloudflare"
  depends_on = [ module.cluster ]
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token = var.cloudflare_token
}

module "traefik" {
  source = "./modules/traefik"
  depends_on = [ module.cluster ]
  
}

resource "local_file" "k3d_kubeconfig" {
  content  = module.cluster.cluster_config
  filename = "k3d_kubeconfig"
}