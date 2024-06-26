module "vpc" {
  source = "git::https://github.com/RedRatInTheHat/simple-vpc.git?ref=721d400"

  vpc_name = "clickhouse"
  vpc_subnets = [
    { vpc_zone = "ru-central1-a", vpc_cidr = "10.0.1.0/24" },
  ]
}

module "clickhouse_vm" {
  source                    = "git::https://github.com/RedRatInTheHat/simple-vms.git?ref=1bf63b4"

  image_family              = "ubuntu-2204-lts"
  instances_count           = 1
  instance_name             = "clickhouse"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  is_preemptible            = true
  has_nat                   = true

  resources = {
    cores         = 4
    memory        = 8
    core_fraction = 20
  }

  metadata = {
    user-data = file("./.meta.yml")
  }

  subnet_ids     = module.vpc.subnet_ids
}

module "vector_vm" {
  source                    = "git::https://github.com/RedRatInTheHat/simple-vms.git?ref=1bf63b4"

  image_family              = "fedora-35"
  instances_count           = 1
  instance_name             = "vector"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  is_preemptible            = true
  has_nat                   = true

  resources = {
    cores         = 4
    memory        = 8
    core_fraction = 20
  }

  metadata = {
    user-data = file("./.meta.yml")
  }

  subnet_ids     = module.vpc.subnet_ids
}

module "lighthouse_vm" {
  source                    = "git::https://github.com/RedRatInTheHat/simple-vms.git?ref=1bf63b4"

  image_family              = "fedora-35"
  instances_count           = 1
  instance_name             = "lighthouse"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  is_preemptible            = true
  has_nat                   = true

  resources = {
    cores         = 4
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
      clickhouse: module.clickhouse_vm.vm_ips[0].public_ip,
      vector    : module.vector_vm.vm_ips[0].public_ip,
      lighthouse: module.lighthouse_vm.vm_ips[0].public_ip,
    }
  })

  filename = "${abspath(path.module)}/../playbook/inventory/prod.yml"
}


