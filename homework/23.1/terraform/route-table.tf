# Route table

resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = var.route_table_name
  network_id = yandex_vpc_network.vpc.id
  static_route {
    destination_prefix = var.route_table_destination
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}
