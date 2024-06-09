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
