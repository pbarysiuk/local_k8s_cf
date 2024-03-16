output "cluster_name" {
    value = module.cluster.cluster_name
}

output "k3d_kubeconfig" {
    value = module.cluster.cluster_config
    sensitive = true
}