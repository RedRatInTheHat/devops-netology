data "terraform_remote_state" "vpc" {
  backend = var.backend_type
  config  = {
    endpoint  = var.yandex_endpoint
    bucket    = var.bucket_name
    region    = var.default_region
    key       = var.tf_state_path

    skip_region_validation      = var.skip_all
    skip_credentials_validation = var.skip_all

    access_key = var.access_key
    secret_key = var.secret_key
  }
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = data.terraform_remote_state.vpc.outputs.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = data.terraform_remote_state.vpc.outputs.subnet_ids
  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = data.terraform_remote_state.vpc.outputs.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = data.terraform_remote_state.vpc.outputs.subnet_ids
  instance_name  = "analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    ssh_key = var.vms_ssh_root_key
  }
}
