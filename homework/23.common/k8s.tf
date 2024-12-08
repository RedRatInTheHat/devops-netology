resource "yandex_kubernetes_cluster" "k8s-regional" {
  name = var.k8s_cluster_name

  network_id = yandex_vpc_network.vpc.id

  master {
    master_location {
      zone      = yandex_vpc_subnet.public.zone
      subnet_id = yandex_vpc_subnet.public.id
    }

    master_location {
      zone      = yandex_vpc_subnet.public-2.zone
      subnet_id = yandex_vpc_subnet.public-2.id
    }

    master_location {
      zone      = yandex_vpc_subnet.public-3.zone
      subnet_id = yandex_vpc_subnet.public-3.id
    }

    public_ip = true

    security_group_ids = [yandex_vpc_security_group.regional-k8s-sg.id]
  }

  service_account_id      = yandex_iam_service_account.regional-k8s-account.id
  node_service_account_id = yandex_iam_service_account.regional-k8s-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller,
    yandex_resourcemanager_folder_iam_member.encrypterDecrypter
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}

resource "yandex_kubernetes_node_group" "k8s-ng" {
  name = "k8s-ng"

  cluster_id  = yandex_kubernetes_cluster.k8s-regional.id

  instance_template {
    name = "{instance.short_id}-{instance_group.id}"
    platform_id = "standard-v3"

    nat = true

    resources {
      cores         = 2
      core_fraction = 20
      memory        = 2
    }

    boot_disk {
      size = 64
      type = "network-ssd"
    }
  }

  allocation_policy {
    location {
        zone      = yandex_vpc_subnet.public.zone
        subnet_id = yandex_vpc_subnet.public.id
    }
  }

  scale_policy {
    auto_scale {
      initial = 3
      min     = 3
      max     = 6
    }
  }

  node_labels = {
    label = "some_label"
  }

  allowed_unsafe_sysctls = ["kernel.msg*", "net.core.somaxconn"]
}

