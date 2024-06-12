output "network_id" {
  value       = yandex_vpc_network.develop.id
  description = "ID of the created netword"
}

output "subnet_ids" {
  value       = [ for i, subnet_info in yandex_vpc_subnet.develop : subnet_info.id ]
  description = "ID of the created subnet"
}

output "subnet_info" {
  value       = [ for i, subnet_info in yandex_vpc_subnet.develop : subnet_info ]
  description = "Full information about the created subnet"
}