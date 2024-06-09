variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  sensitive   = true
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# vpc

variable "vpc_name" {
  type        = string
  default     = "default"
  description = "VPC network&subnet name"
}

variable "vpc_subnets" {
  type = list(object({ vpc_zone = string, vpc_cidr = string }))
  description = "Information about subnets: zone (name of the availability zone for this subnet) and cidr (the blocks of internal IPv4 addresses owned by this subnet)"

  validation {    
    condition     = length(var.vpc_subnets) > 0    
    error_message = "This module requires information about at least one subnet."  
  }
}
