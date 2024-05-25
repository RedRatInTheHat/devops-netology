vm_os_ubuntu_family             = "ubuntu-2004-lts"
vm_platform_id                  = "standard-v3"
vm_is_preemptible               = true
vm_has_nat                      = true
vm_allow_stopping_for_update    = true

vm_web_count            = 2
vm_web_instance_name    = "web"
vm_web_resources        = {
    cores         = 2,
    memory        = 1,
    core_fraction = 20
}

each_vm = [
    {
        vm_name         = "main"
        cpu             = 4
        ram             = 2
        disk_volume     = 8
        core_fraction   = 50
    },
    {
        vm_name         = "replica"
        cpu             = 2
        ram             = 1
        disk_volume     = 5
        core_fraction   = 20
    }
]
