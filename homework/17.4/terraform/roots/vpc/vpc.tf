resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  for_each   = { for index, subnet_info in var.vpc_subnets: index => subnet_info}

  name           = "${var.vpc_name}-${each.key}"
  zone           = each.value.vpc_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [ each.value.vpc_cidr ]
}
