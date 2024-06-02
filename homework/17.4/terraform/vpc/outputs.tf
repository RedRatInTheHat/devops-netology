output "network_id" {
  value       = yandex_vpc_network.develop.id
  description = "ID of the created netword"
}

output "subnet_id" {
  value       = yandex_vpc_subnet.develop.id
  description = "ID of the created subnet"
}

output "subnet_info" {
  value       = {
    description = yandex_vpc_subnet.develop.description
    network_id  = yandex_vpc_subnet.develop.network_id
    labels = yandex_vpc_subnet.develop.labels
    zone = yandex_vpc_subnet.develop.zone
    route_table_id = yandex_vpc_subnet.develop.route_table_id
    v4_cidr_blocks = yandex_vpc_subnet.develop.v4_cidr_blocks
    v6_cidr_blocks = yandex_vpc_subnet.develop.v6_cidr_blocks
    created_at = yandex_vpc_subnet.develop.created_at
  }
  description = "Full information about the created subnet"
}