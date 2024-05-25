resource "local_file" "hosts" {
  content =  <<-EOT
[webservers]
%{ for instance in yandex_compute_instance.web ~}
${instance["name"]}   ansible_host=${instance["network_interface"][0]["nat_ip_address"]}  fqdn=${instance["fqdn"]}
%{ endfor ~}

[databases]
%{ for instance in yandex_compute_instance.db ~}
${instance["name"]}   ansible_host=${instance["network_interface"][0]["nat_ip_address"]}  fqdn=${instance["fqdn"]}
%{ endfor ~}

[storage]
${yandex_compute_instance.storage.name}  ansible_host=${yandex_compute_instance.storage.network_interface[0].nat_ip_address}  fqdn=${yandex_compute_instance.storage.fqdn}

  EOT
  filename = "${abspath(path.module)}/hosts"
}