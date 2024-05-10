output "vm_info" {
    value = [
        for instance in [
            yandex_compute_instance.netology-develop-platform-db, 
            yandex_compute_instance.platform
            ] :{ 
                instance_name   = instance.name,
                external_ip     = instance.network_interface.0.nat_ip_address,
                fqdn            = instance.fqdn
            }
    ]
}