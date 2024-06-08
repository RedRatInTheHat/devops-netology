module "vpc_dev" {
  source = "./vpc"

  vpc_name = "develop"
  vpc_subnets = [
    { vpc_zone = "ru-central1-a", vpc_cidr = "10.0.1.0/24" },
    { vpc_zone = "ru-central1-b", vpc_cidr = "10.0.2.0/24" },
  ]
}

# module "mysql_cluster" {
#   source        = "./mysql-cluster"

#   cluster_name  = "example"
#   network_id    = module.vpc_dev.network_id
#   subnets       = module.vpc_dev.subnet_info
#   is_HA         = true
# }

# module "mysql_db" {
#   source = "./mysql-db"

#   cluster_id  = module.mysql_cluster.cluster_id
#   db_name     = "test"
#   user_name   = "app"
# }

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_dev.subnet_ids[0]]
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
  network_id     = module.vpc_dev.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_dev.subnet_ids[0]]
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
