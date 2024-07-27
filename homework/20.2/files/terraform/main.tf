module "vpc" {
  source = "git::https://github.com/RedRatInTheHat/simple-vpc.git?ref=721d400"

  vpc_name = "grafana_hm"
  vpc_subnets = [
    { vpc_zone = "ru-central1-a", vpc_cidr = "10.0.1.0/24" },
  ]
}

module "node_exporter_vm" {
  source                    = "git::https://github.com/RedRatInTheHat/simple-vms.git?ref=1bf63b4"

  image_family              = "ubuntu-2204-lts"
  instances_count           = 1
  instance_name             = "node-exporter"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  is_preemptible            = true
  has_nat                   = true

  resources = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  metadata = {
    user-data = file("./.meta.yml")
  }

  subnet_ids     = module.vpc.subnet_ids
}

module "prometheus_vm" {
  source                    = "git::https://github.com/RedRatInTheHat/simple-vms.git?ref=1bf63b4"

  image_family              = "ubuntu-2204-lts"
  instances_count           = 1
  instance_name             = "prometheus"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  is_preemptible            = true
  has_nat                   = true

  resources = {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  metadata = {
    user-data = file("./.meta.yml")
  }

  subnet_ids     = module.vpc.subnet_ids
}

module "grafana_vm" {
  source                    = "git::https://github.com/RedRatInTheHat/simple-vms.git?ref=1bf63b4"

  image_family              = "ubuntu-2204-lts"
  instances_count           = 1
  instance_name             = "grafana"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  is_preemptible            = true
  has_nat                   = true

  resources = {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  metadata = {
    user-data = file("./.meta.yml")
  }

  subnet_ids     = module.vpc.subnet_ids
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
  {
    vm_public_ips: { 
      node-exporter: module.node_exporter_vm.vm_ips[0].public_ip
      grafana: module.grafana_vm.vm_ips[0].public_ip,
      prometheus: module.prometheus_vm.vm_ips[0].public_ip
    }
  })

  filename = "${abspath(path.module)}/../ansible/hosts.yml"
}


