resource "k3d_cluster" "k3d_local" {
  name    = "k3d-local"
  servers = 1
  agents  = 1

  kube_api {
    host      = "k3d_local.local"
    host_ip   = "0.0.0.0"
    host_port = 6445
  }

  image   = "rancher/k3s:v1.27.1-k3s1"
  network = "my-custom-net"
  token   = "superSecretToken"

  volume {
    source      = "/tmp"
    destination = "/share"
  }

  port {
    host_port      = 80
    container_port = 80
    node_filters = [
      "server:0:direct",
      "loadbalancer:*",
    ]
  }

  port {
    host_port      = 443
    container_port = 443
    node_filters = [
      //"server:0:direct",
      "loadbalancer:*"
    ]
  }

#   registries {
#     create {
#       name      = "k3d-registry"
#       host      = "k3d-registry.local"
#       image     = "docker.io/some/registry"
#       host_port = "5001"
#     }
#     use = [
#       "k3d-myotherregistry:5000"
#     ]
#     config = <<EOF
# mirrors:
#   "my.company.registry":
#     endpoint:
#       - http://my.company.registry:5000
# EOF
#   }

  k3d {
    disable_load_balancer = false
    disable_image_volume  = false
  }

  k3s {
    extra_args {
      arg          = "--disable=traefik, --tls-san=127.0.0.1"
      node_filters = ["server:*"]
    }
  }


  kubeconfig {
    update_default_kubeconfig = false
    switch_current_context    = true
  }
}