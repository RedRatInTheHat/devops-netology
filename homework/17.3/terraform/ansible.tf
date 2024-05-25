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

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
  { 
    webservers = yandex_compute_instance.web, 
    databases  = yandex_compute_instance.db,
    storage    = yandex_compute_instance.storage
  })

  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "random_password" "each" {
  for_each    = toset([for k, v in yandex_compute_instance.web : v.name ])
  length = 17
}

resource "null_resource" "web_hosts_provision" {
  depends_on = [local_file.hosts_cfg]

  provisioner "local-exec" {
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml --extra-vars '{\"secrets\": ${jsonencode( {for k,v in random_password.each: k=>v.result})} }'"

    on_failure  = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }

  triggers = {
    playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    template_rendered = "${local_file.hosts_cfg.content}" #при изменении inventory-template  }
    password_change = jsonencode( {for k,v in random_password.each: k=>v.result})
  }
}