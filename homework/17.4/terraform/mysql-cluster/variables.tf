variable "cluster_name" {
  type        = string
  description = "Mysql cluster name"
}

variable "network_id" {
  type        = string
  description = "ID of existing network"
}

variable "subnets" {
  type        = any
  description = "Full information about subnets in list."
}

variable "is_HA" {
  type        = bool
  description = "Whether cluster consists of one or more (default 2) nodes"
}

variable "security_group_ids" {
  type        = list(string)
  description = "The security group ids"
}

variable "number_of_hosts" {
  type        = number
  default     = 2
  description = "Number of hosts in HA cluster"
}

variable "environment" {
  type        = string
  default     = "PRESTABLE"
  description = "Deployment environment of the MySQL cluster: PRESTABLE or PRODUCTION"
}

variable "mysql_version" {
  type        = string
  default     = "8.0"
  description = "Version of the MySQL cluster. (allowed versions are: 5.7, 8.0)"
}

variable "resource_preset_id" {
  type        = string
  default     = "b2.medium"
  description = "The ID of the preset for computational resources available to a MySQL host (CPU, memory etc.)"
}

variable "disk_type_id" {
  type        = string
  default     = "network-hdd"
  description = "Type of the storage of MySQL hosts: network-hdd or network-ssd"
}

variable "disk_size" {
  type        = number
  default     = 10
  description = "Volume of the storage available to a MySQL host, in gigabytes."
}

variable "has_public_ip" {
  type        = bool
  default     = true
  description = "Whether the host should get a public IP address."
}


