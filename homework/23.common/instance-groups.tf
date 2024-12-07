# resource "yandex_compute_instance_group" "fixed-ig" {
#   name                = var.instance_group_name
#   folder_id           = var.folder_id
#   service_account_id  = "${yandex_iam_service_account.editor-sa.id}"

#   instance_template {
#     platform_id = var.ig_platform_id
#     resources {
#       core_fraction = var.ig_core_fraction
#       memory = var.ig_memory
#       cores  = var.ig_cores
#     }

#     boot_disk {
#       mode = var.ig_boot_disk_mode
#       initialize_params {
#         image_id = var.lamp_image_id
#         type     = var.ig_boot_disk_type
#         size     = var.ig_boot_disk_size
#       }
#     }

#     network_interface {
#       network_id    = "${yandex_vpc_network.vpc.id}"
#       subnet_ids    = ["${yandex_vpc_subnet.public.id}"]
#       nat           = var.has_nat_for_ig
#     }

#     metadata = {
#       user-data = "${file("${var.lamp-metadata-path}")}"
#     }
#   }

#   scale_policy {
#     fixed_scale {
#       size = var.ig_size
#     }
#   }

#   allocation_policy {
#     zones = var.ig_availability_zones
#   }

#   deploy_policy {
#     max_unavailable = var.dp_max_unavailable
#     max_expansion   = var.max_expansion
#   }

#   health_check {
#     interval            = var.hch_interval
#     timeout             = var.hch_timeout
#     healthy_threshold   = var.hch_healthy_threshold
#     unhealthy_threshold = var.hch_unhealthy_threshold
#     http_options {
#       port = var.hch_http_port
#       path = var.hch_http_path
#     }
#   }

#   load_balancer {
#     target_group_name = var.target_group_name
#   }

#   # application_load_balancer {
#   #   target_group_name = var.alb_target_group_name
#   # }
# }