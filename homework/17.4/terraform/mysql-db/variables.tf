variable "cluster_id" {
  type        = string
  description = "Mysql cluster id"
}

variable "db_name" {
  type        = string
  description = "The name of the database"
}

variable "user_name" {
  type        = string
  description = "The name of the user."
}

variable "password" {
    type        = string
    default     = "password"
    description = "The password of the user."
    sensitive   = true
}

variable "roles" {
    type        = list(string)
    default     = ["ALL"]
    description = "List user's roles in the database."
}