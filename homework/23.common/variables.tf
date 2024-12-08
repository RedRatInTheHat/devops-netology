# Cloud vars
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# VPC

variable "vpc_name" {
    type = string
    default = "vpc"
}

variable "subnet_default_name" {
    type        = string
    default     = "public"
    description = "Default subnet name"
}

variable "public_subnet_name_2" {
    type        = string
    default     = "public_2"
    description = "Default subnet name"
}

variable "public_subnet_name_3" {
    type        = string
    default     = "public_3"
    description = "Default subnet name"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_cidr_2" {
  type        = list(string)
  default     = ["192.168.11.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_cidr_3" {
  type        = list(string)
  default     = ["192.168.12.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_subnet_name" {
    type        = string
    default     = "private"
    description = "Private subnet name"
}

variable "private_subnet_name_2" {
    type        = string
    default     = "private_2"
    description = "Private subnet name"
}

variable "private_subnet_name_3" {
    type        = string
    default     = "private_3"
    description = "Private subnet name"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr_2" {
  type        = list(string)
  default     = ["192.168.21.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr_3" {
  type        = list(string)
  default     = ["192.168.22.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "zone_a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# VM

variable "platform_id" {
  description = "Platform for the virtual machine"
  type        = string
  default     = "standard-v3"
}

variable "core_fraction" {
  description = "Core fraction for the virtual machine"
  type        = number
  default     = 20
}

variable "cores" {
  description = "Number of cores for the virtual machine"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Amount of memory (in GB) for the virtual machine"
  type        = number
  default     = 2
}

variable "metadata-path" {
  type    = string
  default = "./meta.yml"
}

variable "allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "Is stopping for updates allowed"
}

# NAT

variable "vm_nat_name" {
  type        = string
  default     = "nat-vm"
  description = "NAT instance name"
}

variable "nat_ip_address" {
  type        = string
  default     = "192.168.10.254"
  description = "IP address of NAT instance"
}

# Boot Disk for NAT

variable "nat_boot_disk_name" {
  type        = string
  default     = "boot-disk-nat"
  description = "Name of the boot disk for NAT instance"
}

variable "nat_boot_disk_image_id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
  description = "ID of the image to create NAT boot disk"
}

# Boot Disk for other VM

variable "vm_boot_disk_name" {
  type        = string
  default     = "boot-disk"
  description = "Name of the boot disk for NAT instance"
}

variable "private_vm_boot_disk_name" {
  type        = string
  default     = "private-vm-boot-disk"
  description = "Name of the boot disk for NAT instance"
}

variable "vm_boot_disk_image_id" {
  type        = string
  default     = "fd8ludhmmor1p0c3q6k0"
  description = "ID of the image to create public vm boot disk"
}

# Boot Disk common

variable "boot_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Type of the boot disk for NAT instance"
}

variable "boot_disk_size" {
  type        = number
  default     = 10
  description = "Size of the boot disk (in GB)"
}

# Security Group

variable "sg_nat_name" {
  type        = string
  description = "The name of the NAT instance security group"
  default     = "nat-instance-security-group"
}

variable "alb_sg_name" {
  type        = string
  default     = "alb-sg"
  description = "The name of the ALB instance security group"
}

variable "mysql_sg_name" {
  type        = string
  default     = "mysql-sg"
  description = "The name of the MySQL security group."
}

variable "k8s_sg_name" {
  type        = string
  default     = "regional-k8s-sg"
  description = "The name of the MySQL K8S group."
}

# Public VM

variable "public_vm_name" {
  type        = string
  default     = "public-vm"
  description = "Public instance name"
}

# Private VM

variable "private_vm_name" {
  type        = string
  default     = "private-vm"
  description = "Private instance name"
}

# Route table

variable "route_table_name" {
  type        = string
  default     = "route_table"
  description = "Route table name"
}

variable "route_table_destination" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Route prefix in CIDR notation."
}

# Service accounts

variable "service_account_name" {
  type        = string
  default     = "bucket-sa"
  description = "The name of the service account"
}

variable "sa_admin_role" {
  type        = string
  default     = "storage.admin"
  description = "The IAM role to assign"
}

variable "static_key_description" {
  type        = string
  default     = "Static access key for object storage"
  description = "The description of static key"
}

variable "editor_sa_name" {
  description = "The name of the Yandex IAM editor service account."
  type        = string
  default     = "editor"
}

variable "editor_role" {
  type        = string
  default     = "editor"
  description = "The IAM role to assign"
}

variable "kms_role" {
  type        = string
  default     = "kms.keys.encrypterDecrypter"
  description = "The role assigned to the IAM member for KMS."
}

variable "k8s_service_account_name" {
  type        = string
  default     = "regional-k8ser"
  description = "The name of the Kubernetes regional service account."
}

variable "k8s_service_account_description" {
  type        = string
  default     = "K8S regional service account"
  description = "The description of the Kubernetes regional service account."
}

variable "k8s_clusters_agent_role" {
  type        = string
  default     = "k8s.clusters.agent"
  description = "The role assigned to the service account."
}

variable "vpc_public_admin_role" {
  type        = string
  default     = "vpc.publicAdmin"
  description = "The role for public admin access to VPC."
}

variable "images_puller_role" {
  type        = string
  default     = "container-registry.images.puller"
  description = "The role for pulling images from the container registry."
}

variable "encrypter_decrypter_role" {
  type        = string
  default     = "kms.keys.encrypterDecrypter"
  description = "The role for encrypting and decrypting keys."
}

# Bucket

variable "bucket_name" {
  default     = "image-bucket-netology-23.2"
  type        = string
  description = "The name of the storage bucket. Must be unique within Yandex Cloud."
}

variable "kms_bucket_name" {
  default     = "bucket-netology-23.3.1"
  type        = string
  description = "The name of the storage bucket. Must be unique within Yandex Cloud."
}

variable "bucket_max_size" {
  default     = 104857600  // Default value set to 100 MB
  type        = number
  description = "Maximum size of the storage bucket in bytes."
}

variable "is_readable" {
  type        = bool
  default     = true
  description = "Are bucket files allowed to be read by anonymous"
}

variable "sse_algorithm" {
  type        = string
  default     = "aws:kms"
  description = "The server-side encryption algorithm."
}

# Bucket image

variable "bucket_image_key" {
  type        = string
  default     = "greeting.jpg"
  description = "The key (name) for the storage object."
}

variable "bucket_image_source_path" {
  type        = string
  default     = "./img/oh-hi-mark.jpg"
  description = "The local path to the file that will be uploaded to the storage bucket."
}

# Instance group

variable "instance_group_name" {
  type        = string
  default     = "ig"
  description = "The name of the Yandex Compute Instance Group."
}

variable "ig_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "The platform ID used for the instances."
}

variable "ig_core_fraction" {
  type        = number
  default     = 20
  description = "The core fraction allocated to the instances."
}

variable "ig_memory" {
  type        = number
  default     = 1
  description = "The amount of memory (in GiB) allocated to the instances."
}

variable "ig_cores" {
  type        = number
  default     = 2
  description = "The number of cores allocated to the instances."
}

variable "ig_boot_disk_mode" {
  type        = string
  default     = "READ_WRITE"
  description = "The mode of the boot disk."
}

variable "lamp_image_id" {
  type        = string
  default     = "fd827b91d99psvq5fjit"
  description = "The Yandex Cloud image ID for the boot disk."
}

variable "ig_boot_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "The type of the boot disk."
}

variable "ig_boot_disk_size" {
  type        = number
  default     = 3
  description = "The size of the boot disk (in GiB)."
}

variable "has_nat_for_ig" {
  type        = bool
  default     = true
  description = "Whether to enable NAT for the instances."
}

variable "ig_size" {
  type        = number
  default     = 3
  description = "The desired size of the compute instance group."
}

variable "ig_availability_zones" {
  type        = list(string)
  default     = ["ru-central1-a"]
  description = "A list of availability zones for instance deployment."
}

variable "dp_max_unavailable" {
  type        = number
  default     = 1
  description = "The maximum number of unavailable instances during deployment."
}

variable "max_expansion" {
  type        = number
  default     = 0
  description = "The maximum number of instances that can be expanded during deployment."
}

variable "lamp-metadata-path" {
  type    = string
  default = "./lamp-meta.yml"
}

variable "hch_interval" {
  type        = number
  default     = 30
  description = "Interval in seconds between health checks."
}

variable "hch_timeout" {
  type        = number
  default     = 10
  description = "Timeout in seconds for each health check request."
}

variable "hch_healthy_threshold" {
  type        = number
  default     = 2
  description = "Number of consecutive successful checks required before marking the instance as healthy."
}

variable "hch_unhealthy_threshold" {
  type        = number
  default     = 2
  description = "Number of consecutive failed checks required before marking the instance as unhealthy."
}

variable "hch_http_port" {
  type        = number
  default     = 80
  description = "Port on which to perform HTTP health checks."
}

variable "hch_http_path" {
  type        = string
  default     = "/"
  description = "Path for the health check request."
}

variable "target_group_name" {
  type        = string
  default     = "fixed-ig-tg"
  description = "The name of the target group."
}

variable "alb_target_group_name" {
  type        = string
  default     = "fixed-ig-alb-tg"
  description = "The name of the target group."
}

# Network balancer

variable "nlb_name" {
  type        = string
  default     = "network-balancer"
  description = "The name of the network load balancer."
}

variable "nlb_listener_name" {
  type        = string
  default     = "nlb-listener"
  description = "The name of the listener for the network load balancer."
}

variable "nlb_listener_port" {
  type        = number
  default     = 80
  description = "The port on which the listener will listen."
}

variable "nlb_healthcheck_name" {
  type        = string
  default     = "balancer-health-check"
  description = "The name of the health check for the load balancer."
}

variable "nlb_unhealthy_threshold" {
  type        = number
  default     = 2
  description = "The number of failed health checks before a target is considered unhealthy."
}

variable "nlb_healthy_threshold" {
  type        = number
  default     = 2
  description = "The number of successful health checks before a target is considered healthy."
}

variable "nlb_healthcheck_port" {
  type        = number
  default     = 80
  description = "The port used for health checking the targets."
}

# Application balancer

variable "alb_backend_group_name" {
  type        = string
  default     = "alb-backend-group"
  description = "The name of the backend group for the application load balancer."
}

variable "alb_backend_name" {
  type        = string
  default     = "alb-backend"
  description = "The name of the backend for the application load balancer."
}

variable "alb_backend_port" {
  type        = number
  default     = 80
  description = "The port on which the backend will listen."
}

variable "alb_healthcheck_timeout" {
  type        = string
  default     = "10s"
  description = "The timeout for the health check requests."
}

variable "alb_healthcheck_interval" {
  type        = string
  default     = "2s"
  description = "The interval between health checks."
}

variable "alb_healthcheck_port" {
  type        = number
  default     = 80
  description = "The port used for the health check."
}

variable "alb_healthcheck_path" {
  type        = string
  default     = "/"
  description = "The path for the HTTP health check."
}

variable "alb_virtual_host_name" {
  type        = string
  default     = "alb-virtual-host"
  description = "The name of the Application Load Balancer (ALB) virtual host."
}

variable "alb_route_name" {
  type        = string
  default     = "alb-route"
  description = "The name of the route for the ALB virtual host."
}

variable "alb_timeout" {
  type        = string
  default     = "60s"
  description = "The timeout value for the backend group in seconds."
}

variable "alb_router_name" {
  type        = string
  default     = "alb-router"
  description = "The name of the HTTP router for the application load balancer."
}

variable "alb_name" {
  type        = string
  default     = "application-load-balancer"
  description = "The name of the Application Load Balancer (ALB)."
}

variable "alb_listener_name" {
  type        = string
  default     = "alb-listener"
  description = "The name of the ALB listener."
}

variable "alb_listener_ports" {
  type        = list(number)
  default     = [80]
  description = "A list of ports for the ALB listener."
}

# KMS key

variable "kms_key_name" {
  type        = string
  default     = "bucket-kms-key"
  description = "The name of the KMS key."
}

variable "kms_key_description" {
  type        = string
  default     = "KMS key for secret bucket"
  description = "Description for the KMS key."
}

variable "kms_key_algorithm" {
  type        = string
  default     = "AES_256"
  description = "The default algorithm for the KMS key."
}

variable "kms_key_rotation_period" {
  type        = string
  default     = "24h"
  description = "The rotation period for the KMS key."
}

# MySQL

variable "mysql_cluster_name" {
  type        = string
  default     = "mysql-cluster"
  description = "The name of the MySQL cluster."
}

variable "mysql_environment" {
  type        = string
  default     = "PRESTABLE"
  description = "The environment for the MySQL cluster."
}

variable "mysql_version" {
  type        = string
  default     = "8.0"
  description = "The version of MySQL to be used in the cluster."
}

variable "mysql_deletion_protection" {
  type        = bool
  default     = true
  description = "Enable or disable deletion protection for the MySQL cluster."
}

variable "mysql_resource_preset_id" {
  type        = string
  default     = "b1.medium"
  description = "Resource preset ID for the MySQL cluster."
}

variable "mysql_disk_type_id" {
  type        = string
  default     = "network-ssd"
  description = "Disk type ID for the MySQL cluster."
}

variable "mysql_disk_size" {
  type        = number
  default     = 20
  description = "Disk size in GB for the MySQL cluster."
}

variable "mysql_maintenance_window_type" {
  type        = string
  default     = "ANYTIME"
  description = "Type of maintenance window for the MySQL cluster."
}

variable "mysql_backup_window_start_hours" {
  type        = number
  default     = 23
  description = "Start hour for the backup window."
}

variable "mysql_backup_window_start_minutes" {
  type        = number
  default     = 59
  description = "Start minutes for the backup window."
}

variable "mysql_host_assign_public_ip" {
  type        = bool
  default     = false
  description = "Whether to assign a public IP to the host in the MySQL cluster."
}

variable "mysql_database_name" {
  type        = string
  default     = "netology_db"
  description = "The name of the MySQL database."
}

variable "mysql_user_name" {
  type        = string
  default     = "sqler"
  description = "The name of the MySQL user."
}

variable "mysql_user_password" {
  type        = string
  description = "The password for the MySQL user."
}

variable "mysql_user_roles" {
  type        = list(string)
  default     = ["ALL"]
  description = "Roles assigned to the MySQL user for the database."
}

# K8S cluster

variable "k8s_cluster_name" {
  type        = string
  default     = "k8s-regional"
  description = "The name of the Kubernetes cluster."
}