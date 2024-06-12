# cloud
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

variable "default_region" {
  type        = string
  default     = "ru-central1"
  description = "Yandex region. One and only"
}

# common

variable "vms_ssh_root_key" {
  type        = string
  default     = "your_ssh_ed25519_key"
  description = "ssh-keygen -t ed25519"
}

# remote state

variable "backend_type" {
  type        = string
  description = "The remote backend to use."
}

variable "yandex_endpoint" {
  type        = string
  description = "Yandex storage endpoint"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 Bucket."
}

variable "tf_state_path" {
  type        = string
  description = "Path to the state file inside the S3 Bucket."
}

variable "skip_all" {
  type        = bool
  description = "Whether skip validation"
}

variable "access_key" {
  type        = string
  description = "Service account access key."
}

variable "secret_key" {
  type        = string
  description = "Service account secret key."
}