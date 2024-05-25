###cloud vars
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
  description = "VPC network&subnet name"
}

# instances common info

variable "vm_os_ubuntu_family" {
  type        = string
  description = "The family name of an image. Used to search the latest image in a family."
}

variable "vm_platform_id" {
  type        = string
  description = "The type of virtual machine to create."
}

variable "vm_is_preemptible" {
  type        = bool
  description = "Is the instance preemptible."
}

variable "vm_has_nat" {
  type        = bool
  description = "Is a public address provided."
}

variable "vm_allow_stopping_for_update" {
  type        = bool
  description = "Is it allowed to stop a VM instance to make changes"
}

# web instances info

variable "vm_web_count" {
  type        = number
  description = "Number of instances"
}

variable "vm_web_instance_name" {
  type        = string
  description = "Name of created virtual machine."
}

variable "vm_web_resources" {
  type        = object({ cores=number, memory=number, core_fraction=number })
  description = "Resources for instances"
}

# db instances info

variable "each_vm" {
  type        = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number, core_fraction=number }))
  description = "Parameters for database instances"
}
