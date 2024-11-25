resource "yandex_lb_network_load_balancer" "network-balancer" {
  name = var.nlb_name

  listener {
    name = var.nlb_listener_name
    port = var.nlb_listener_port
  }

  attached_target_group {
    target_group_id = "${yandex_compute_instance_group.fixed-ig.load_balancer.0.target_group_id}"
    healthcheck {
      name                = var.nlb_healthcheck_name
      unhealthy_threshold = var.nlb_unhealthy_threshold
      healthy_threshold   = var.nlb_healthy_threshold
      http_options {
        port = var.nlb_healthcheck_port
      }
    }
  }
}