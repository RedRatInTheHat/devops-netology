# Network balancer

# resource "yandex_lb_network_load_balancer" "network-balancer" {
#   name = var.nlb_name

#   listener {
#     name = var.nlb_listener_name
#     port = var.nlb_listener_port
#   }

#   attached_target_group {
#     target_group_id = "${yandex_compute_instance_group.fixed-ig.load_balancer.0.target_group_id}"
#     healthcheck {
#       name                = var.nlb_healthcheck_name
#       unhealthy_threshold = var.nlb_unhealthy_threshold
#       healthy_threshold   = var.nlb_healthy_threshold
#       http_options {
#         port = var.nlb_healthcheck_port
#       }
#     }
#   }
# }

# Application balancer

resource "yandex_alb_backend_group" "alb-bg" {
  name                     = var.alb_backend_group_name

  http_backend {
    name                   = var.alb_backend_name
    port                   = var.alb_backend_port
    target_group_ids       = [yandex_compute_instance_group.fixed-ig.application_load_balancer.0.target_group_id]
    healthcheck {
      timeout              = var.alb_healthcheck_timeout
      interval             = var.alb_healthcheck_interval
      healthcheck_port     = var.alb_healthcheck_port
      http_healthcheck {
        path               = var.alb_healthcheck_path
      }
    }
  }
}

resource "yandex_alb_virtual_host" "alb-vh" {
  name                    = var.alb_virtual_host_name
  http_router_id          = yandex_alb_http_router.alb-router.id
  route {
    name                  = var.alb_route_name
    http_route {
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.alb-bg.id
        timeout           = var.alb_timeout
      }
    }
  }
}


resource "yandex_alb_http_router" "alb-router" {
  name   = var.alb_router_name
}

resource "yandex_alb_load_balancer" "alb" {
  name               = var.alb_name
  network_id         = yandex_vpc_network.vpc.id
  security_group_ids = [yandex_vpc_security_group.alb-sg.id]

  allocation_policy {
    location {
      zone_id   = var.default_zone
      subnet_id = yandex_vpc_subnet.public.id
    }
  }

  listener {
    name = var.alb_listener_name
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = var.alb_listener_ports
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.alb-router.id
      }
    }
  }
}