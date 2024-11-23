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

variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_subnet_name" {
    type        = string
    default     = "private"
    description = "Private subnet name"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
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

# Service account

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

# Bucket

variable "bucket_name" {
  default     = "image-bucket-netology-23.2"
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

# Bucket image

variable "bucket_image_key" {
  type        = string
  default     = "greeting"
  description = "The key (name) for the storage object."
}

variable "bucket_image_source_path" {
  type        = string
  default     = "./img/oh-hi-mark.jpg"
  description = "The local path to the file that will be uploaded to the storage bucket."
}