resource "local_file" "ansible_hosts" {
  content  = <<EOT
[master]
master_node ansible_ssh_host=${yandex_compute_instance.master-vm.network_interface.0.nat_ip_address}

[slave]
slave_node_1 ansible_ssh_host=${yandex_compute_instance.slave-vm-1.network_interface.0.nat_ip_address}
slave_node_2 ansible_ssh_host=${yandex_compute_instance.slave-vm-2.network_interface.0.nat_ip_address}

EOT
  filename = "ansible/hosts"
}

resource "local_file" "tf_variables" {
  content  = <<EOT
master_ip: "${yandex_compute_instance.master-vm.network_interface.0.nat_ip_address}"
slave_1_ip: "${yandex_compute_instance.slave-vm-1.network_interface.0.nat_ip_address}"
slave_2_ip: "${yandex_compute_instance.slave-vm-2.network_interface.0.nat_ip_address}"

oauth_token: "${var.oauth_token}"
EOT
  filename = "ansible/group_vars/all/tf_variables.yml"
}


resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "cd ansible && ansible-playbook playbook.yaml"
  }

  depends_on = [
    local_file.ansible_hosts
  ]
}