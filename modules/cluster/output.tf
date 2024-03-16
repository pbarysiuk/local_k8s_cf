data "k3d_cluster" "k3d_local" {
    name = "k3d-local"
}

output "cluster_name" {
  value = data.k3d_cluster.k3d_local.name
}

output "cluster_config" {
  value = data.k3d_cluster.k3d_local.kubeconfig_raw
}