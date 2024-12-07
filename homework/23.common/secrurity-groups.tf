# # Security Groups

# resource "yandex_vpc_security_group" "nat-instance-sg" {
#   name       = var.sg_nat_name
#   network_id = yandex_vpc_network.vpc.id

#   egress {
#     protocol       = "ANY"
#     description    = "any"
#     v4_cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     protocol       = "TCP"
#     description    = "ssh"
#     v4_cidr_blocks = ["0.0.0.0/0"]
#     port           = 22
#   }
# }

# resource "yandex_vpc_security_group" "alb-sg" {
#   name        = var.alb_sg_name
#   network_id  = yandex_vpc_network.vpc.id

#   egress {
#     protocol       = "ANY"
#     description    = "any"
#     v4_cidr_blocks = ["0.0.0.0/0"]
#     from_port      = 1
#     to_port        = 65535
#   }

#   ingress {
#     protocol       = "TCP"
#     description    = "ext-http"
#     v4_cidr_blocks = ["0.0.0.0/0"]
#     port           = 80
#   }

#   ingress {
#     protocol       = "TCP"
#     description    = "ext-https"
#     v4_cidr_blocks = ["0.0.0.0/0"]
#     port           = 443
#   }

#   ingress {
#     protocol          = "TCP"
#     description       = "healthchecks"
#     predefined_target = "loadbalancer_healthchecks"
#     port              = 30080
#   }
# }

resource "yandex_vpc_security_group" "mysql-sg" {
  name       = var.mysql_sg_name
  network_id = yandex_vpc_network.vpc.id

  ingress {
    description    = "MySQL®"
    port           = 3306
    protocol       = "TCP"
    v4_cidr_blocks = [ "0.0.0.0/0" ]
  }
}