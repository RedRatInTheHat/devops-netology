### cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "The family name of an image. Used to search the latest image in a family."
}

variable "vm_web_instance_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name of created virtual machine."
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "The type of virtual machine to create."
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "CPU cores for the instance."
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Memory size in GB."
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 20
  description = "Baseline performance for a core as a percent."
}

variable "vm_web_is_preemptible" {
  type        = bool
  default     = true
  description = "Is the instance preemptible."
}

variable "vm_web_has_nat" {
  type        = bool
  default     = true
  description = "Is a public address provided."
}

variable "vm_web_has_access_to_console" {
  type        = number
  default     = 1
  description = "Is access to serial console enabled (0/1)"
}

### ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL44om5P+zHY7iA+u+VUKYspMpmyQul66wp7ul+8vEtb redrat@redrat-All-Series"
  description = "ssh-keygen -t ed25519"
}
