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

variable "service_account_file_path" {
  type        = string
  description = "The path to the service account key file."
}

# variable "default_region" {
#   type        = string
#   default     = "ru-central1"
#   description = "The yandex cloud region. One and only."
# }

# variable "aws_mock" {
#   type        = object({
#     skip_all    = bool,
#     access_key  = string,
#     secret_key  = string
#   })
#   default = {
#     skip_all    = true,
#     access_key  = "mock_access_key",
#     secret_key  = "mock_secret_key"
#   }
#   description = "The mock parameters for aws provider."
# }

# service account variables
variable "service_account_name" {
    type        = string
    description = "Name of the service account."
}

variable "service_account_storage_role" {
    type        = string
    description = "The role that should be assigned in storage."
}

variable "service_account_ydb_role" {
    type        = string
    description = "The role that should be assigned in ydb."
}

variable "member_type" {
    type        = string
    description = "The type of identity being assigned a role. Acceptable values are: 'serviceAccount', 'userAccount', 'federatedUser', 'group', or 'system'."

    validation {
        condition     = contains(["serviceAccount", "userAccount", "federatedUser", "group", "system"], var.member_type)
        error_message = "The member_type must be one of the following: 'serviceAccount', 'userAccount', 'federatedUser', 'group', or 'system'."
    }
}

variable "sa-static-key-description" {
    type        = string
    description = "The description of the service account static key."
}

# random string variables

variable "random_string_length" {
  type        = number
  description = "The length of the random string to add to bucket name"
}

variable "has_upper" {
  type        = bool
  description = "Whether include uppercase alphabet characters in the result."
}

variable "has_lower" {
  type        = bool
  description = "Whether include lowercase alphabet characters in the result."
}

variable "has_numeric" {
  type        = bool
  description = "Whether include numeric characters in the result."
}

variable "has_special" {
  type        = string
  description = "Wherer include special characters in the result."
}

# storage variables

variable "backet_base_name" {
  type        = string
  description = "The base name of the bucket. Random symbols will be added to keep name unique."
}

variable "bucket_max_size" {
  type        = string
  description = "The size of bucket, in bytes."
}

variable "anonymous_access" {
  type        = object({read=bool, list=bool, config_read=bool})
  description = "Anonymous access to objects: read is for reading objects, list is for listing object, config_read is allegedly for reading configuration."
}

# ydb variables

variable "database_name" {
  type        = string
  description = "Name for the Yandex Database serverless cluster."
}

variable "provisioned_rcu_limit" {
  type        = number
  description = "The consumption of Request Units per second that is billed hourly according to the tariff. A value of zero disables hourly billing."
}

variable "storage_size_limit" {
  type        = number
  description = "Data volume, in GB"
}

# variable "lock_table_name" {
#   type        = string
#   description = "The name of the table holding terraform lock."
# }

# variable "billing_mode" {
#   type        = string
#   description = "The billing model. Only PAY_PER_REQUEST is acceptable."
# }

# variable "lock_column_name" {
#   type        = string
#   description = "The name of column with lock IDs. Only LockID is acceptable"

#   validation {
#       condition     = var.lock_column_name == "LockID"
#       error_message = "Only LockID is acceptable"
#   }
# }

# variable "lock_column_type" {
#   type        = string
#   description = "The type of column with lock IDs. Only S (String) is acceptable"

#   validation {
#       condition     = var.lock_column_type == "S"
#       error_message = "Only S is acceptable (S is for String)."
#   }
# }


